import 'package:cloud_firestore/cloud_firestore.dart';

/// One question's outcome inside a student's quiz attempt.
///
/// Persisted inside the `answers` array of a
/// `lessons/{lessonId}/quizResults/{studentId}` document.
class QuizAnswerRecord {
  final String questionText;
  final List<String> options;
  final int selectedIndex; // -1 = not answered / timed out
  final int correctIndex;
  final bool isCorrect;

  QuizAnswerRecord({
    required this.questionText,
    required this.options,
    required this.selectedIndex,
    required this.correctIndex,
    required this.isCorrect,
  });

  bool get wasAnswered => selectedIndex >= 0;

  Map<String, dynamic> toMap() => {
        'questionText': questionText,
        'options': options,
        'selectedIndex': selectedIndex,
        'correctIndex': correctIndex,
        'isCorrect': isCorrect,
      };

  factory QuizAnswerRecord.fromMap(Map<String, dynamic> map) {
    return QuizAnswerRecord(
      questionText: map['questionText'] ?? '',
      options: ((map['options'] as List?) ?? const [])
          .map((e) => e.toString())
          .toList(),
      selectedIndex: (map['selectedIndex'] as num?)?.toInt() ?? -1,
      correctIndex: (map['correctIndex'] as num?)?.toInt() ?? -1,
      isCorrect: map['isCorrect'] == true,
    );
  }
}

/// A single student's attempt of one lesson's quiz.
///
/// Mirrors a `lessons/{lessonId}/quizResults/{studentId}` document. Older
/// documents created before the tracker feature won't have `studentName`,
/// `lessonTitle` or `answers` — the factory degrades gracefully for those.
class QuizAttemptRecord {
  final String studentId;
  final String studentName;
  final String lessonId;
  final String lessonTitle;
  final String classId;
  final int score;
  final int totalPoints;
  final int attemptCount;
  final DateTime? attemptedAt;
  final List<QuizAnswerRecord> answers;

  QuizAttemptRecord({
    required this.studentId,
    required this.studentName,
    required this.lessonId,
    required this.lessonTitle,
    required this.classId,
    required this.score,
    required this.totalPoints,
    required this.attemptCount,
    required this.attemptedAt,
    required this.answers,
  });

  /// Percentage score, 0–100.
  double get percent => totalPoints == 0 ? 0 : (score / totalPoints) * 100;

  /// True when per-question detail was captured for this attempt.
  bool get hasAnswerDetail => answers.isNotEmpty;

  int get correctCount => answers.where((a) => a.isCorrect).length;

  factory QuizAttemptRecord.fromMap(
    Map<String, dynamic> map, {
    String? fallbackStudentId,
    String? fallbackLessonId,
    String? fallbackLessonTitle,
  }) {
    final rawTitle = (map['lessonTitle'] as String?)?.trim();
    return QuizAttemptRecord(
      studentId: (map['studentId'] as String?) ?? fallbackStudentId ?? '',
      studentName: (map['studentName'] as String?)?.trim() ?? '',
      lessonId: (map['lessonId'] as String?) ?? fallbackLessonId ?? '',
      lessonTitle: (rawTitle != null && rawTitle.isNotEmpty)
          ? rawTitle
          : (fallbackLessonTitle ?? 'Quiz'),
      classId: (map['classId'] as String?) ?? '',
      score: (map['score'] as num?)?.toInt() ?? 0,
      totalPoints: (map['totalPoints'] as num?)?.toInt() ?? 100,
      attemptCount: (map['attemptCount'] as num?)?.toInt() ?? 1,
      attemptedAt: (map['attemptedAt'] as Timestamp?)?.toDate(),
      answers: ((map['answers'] as List?) ?? const [])
          .map((e) =>
              QuizAnswerRecord.fromMap(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
  }
}
