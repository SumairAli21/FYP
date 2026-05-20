import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englify_app/models/quiz_attempt_model.dart';
import 'package:englify_app/services/firestore_keys.dart';

/// Reads quiz-attempt data for the Teacher Quiz Tracker.
///
/// Source of truth: `lessons/{lessonId}/quizResults/{studentId}`
/// (written by [PointsService.savequizresult]). Lessons are top-level
/// documents carrying a `teacherId`, so a teacher's whole tracker is built
/// from the lessons they own.
class TrackerService {
  final _db = FirebaseFirestore.instance;

  /// Every student who has attempted at least one quiz in the teacher's
  /// lessons, each with all of their attempts attached. Sorted by name.
  Future<List<StudentTrackerSummary>> getStudentsWhoAttempted(
    String teacherId,
  ) async {
    final lessonsSnap = await _db
        .collection(FirestoreKeys.lessons)
        .where(FirestoreKeys.teacherId, isEqualTo: teacherId)
        .get();

    // studentId -> their attempts
    final Map<String, List<QuizAttemptRecord>> byStudent = {};

    for (final lesson in lessonsSnap.docs) {
      final lessonTitle = (lesson.data()['title'] as String?) ?? 'Lesson';

      final resultsSnap = await _db
          .collection(FirestoreKeys.lessons)
          .doc(lesson.id)
          .collection('quizResults')
          .get();

      for (final r in resultsSnap.docs) {
        final record = QuizAttemptRecord.fromMap(
          r.data(),
          fallbackStudentId: r.id,
          fallbackLessonId: lesson.id,
          fallbackLessonTitle: lessonTitle,
        );
        byStudent.putIfAbsent(record.studentId, () => []).add(record);
      }
    }

    final summaries = <StudentTrackerSummary>[];

    for (final entry in byStudent.entries) {
      final studentId = entry.key;

      // Newest attempt first.
      final attempts = entry.value
        ..sort((a, b) {
          final at = a.attemptedAt;
          final bt = b.attemptedAt;
          if (at == null && bt == null) return 0;
          if (at == null) return 1;
          if (bt == null) return -1;
          return bt.compareTo(at);
        });

      final profile = await _resolveStudentProfile(studentId, attempts);

      summaries.add(StudentTrackerSummary(
        studentId: studentId,
        studentName: profile.name,
        profileImage: profile.image,
        attempts: attempts,
      ));
    }

    summaries.sort((a, b) =>
        a.studentName.toLowerCase().compareTo(b.studentName.toLowerCase()));
    return summaries;
  }

  /// Resolves a display name + avatar from `users/{studentId}`, falling back
  /// to the name denormalised on the quiz result, then to "Student".
  Future<({String name, String image})> _resolveStudentProfile(
    String studentId,
    List<QuizAttemptRecord> attempts,
  ) async {
    String name = '';
    String image = '';

    try {
      final userDoc =
          await _db.collection(FirestoreKeys.users).doc(studentId).get();
      final ud = userDoc.data();
      if (ud != null) {
        final n = (ud['name'] as String?)?.trim();
        name = (n != null && n.isNotEmpty)
            ? n
            : ((ud['displayName'] as String?)?.trim() ??
                (ud['username'] as String?)?.trim() ??
                '');
        image = (ud['profileImageUrl'] as String?) ??
            (ud['photoURL'] as String?) ??
            (ud['profileImage'] as String?) ??
            '';
      }
    } catch (e) {
      print('⚠️ TrackerService: failed to load user $studentId: $e');
    }

    if (name.isEmpty) {
      name = attempts
          .firstWhere(
            (a) => a.studentName.isNotEmpty,
            orElse: () => attempts.first,
          )
          .studentName;
    }
    if (name.isEmpty) name = 'Student';

    return (name: name, image: image);
  }
}

/// Aggregated tracker view of one student and all their quiz attempts.
class StudentTrackerSummary {
  final String studentId;
  final String studentName;
  final String profileImage;
  final List<QuizAttemptRecord> attempts;

  StudentTrackerSummary({
    required this.studentId,
    required this.studentName,
    required this.profileImage,
    required this.attempts,
  });

  int get quizzesAttempted => attempts.length;
  int get totalScore => attempts.fold(0, (acc, a) => acc + a.score);
  int get totalPossible => attempts.fold(0, (acc, a) => acc + a.totalPoints);
  double get averagePercent =>
      totalPossible == 0 ? 0 : (totalScore / totalPossible) * 100;
}
