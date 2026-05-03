import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/firestore_keys.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StudentDashboardViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _db = FirebaseFirestore.instance;

  // ── Student profile
  String studentName = '';
  int level = 1;
  int totalPoints = 0;

  // ── Stats
  int completedLessons = 0;
  int totalLessons = 0;
  double performance = 0.0; // avg score %

  // ── Top performing class
  String topClassName = '';
  String topClassId = '';
  double topClassScore = 0.0;

  String get studentId => _authService.currentuser?.uid ?? '';

  Future<void> init() async {
    setBusy(true);
    try {
      await Future.wait([
        _loadProfile(),
        _loadStats(),
      ]);
    } catch (e) {
      print('StudentDashboard init error: $e');
    }
    setBusy(false);
  }

  // ── Load student profile from users collection
  Future<void> _loadProfile() async {
    final doc = await _db
        .collection(FirestoreKeys.users)
        .doc(studentId)
        .get();
    final data = doc.data() ?? {};
    studentName = data['name'] ?? data['displayName'] ?? 'Student';
    level = (data['level'] as num?)?.toInt() ?? 1;
    totalPoints = (data['totalCoins'] as num?)?.toInt() ?? 0;
  }

  // ── Load lessons done, performance, top class
  Future<void> _loadStats() async {
    // Get all classes the student is in
    final allClasses = await _db.collection('classes').get();

    int totalL = 0;
    int completedL = 0;
    int earnedPoints = 0;
    int possiblePoints = 0;

    String bestClassId = '';
    String bestClassName = '';
    double bestScore = -1;

    for (final cls in allClasses.docs) {
      // Check if student is a member
      final memberDoc = await _db
          .collection('classes')
          .doc(cls.id)
          .collection('members')
          .doc(studentId)
          .get();

      if (!memberDoc.exists || memberDoc.data()?['role'] != 'student') {
        continue;
      }

      // Get lessons for this class (top-level lessons collection)
      final lessons = await _db
          .collection(FirestoreKeys.lessons)
          .where(FirestoreKeys.classId, isEqualTo: cls.id)
          .get();

      totalL += lessons.docs.length;

      int classEarned = 0;
      int classPossible = 0;

      for (final lesson in lessons.docs) {
        // Quiz result
        final resultDoc = await _db
            .collection(FirestoreKeys.lessons)
            .doc(lesson.id)
            .collection('quizResults')
            .doc(studentId)
            .get();

        if (resultDoc.exists) {
          completedL++;
          final d = resultDoc.data()!;
          final s = (d['score'] as num?)?.toInt() ?? 0;
          final p = (d['totalPoints'] as num?)?.toInt() ?? 100;
          earnedPoints += s;
          possiblePoints += p;
          classEarned += s;
          classPossible += p;
        }
      }

      // Check if this class is best
      if (classPossible > 0) {
        final classAvg = (classEarned / classPossible) * 100;
        if (classAvg > bestScore) {
          bestScore = classAvg;
          bestClassId = cls.id;
          bestClassName = cls.data()['name'] ?? 'Class';
        }
      }
    }

    totalLessons = totalL;
    completedLessons = completedL;
    performance = possiblePoints == 0
        ? 0.0
        : (earnedPoints / possiblePoints) * 100;

    topClassId = bestClassId;
    topClassName = bestClassName;
    topClassScore = bestScore < 0 ? 0.0 : bestScore;

    print(
        '📊 Student: lessons=$completedLessons/$totalLessons, perf=$performance%, topClass=$topClassName ($topClassScore%)');
  }

  void onContinueTap() {
    if (topClassId.isEmpty) return;
    _navigationService.navigateTo(
      Routes.classroomdetailView,
      arguments: ClassroomdetailViewArguments(
        classroom: {'id': topClassId, 'name': topClassName},
      ),
    );
  }
}