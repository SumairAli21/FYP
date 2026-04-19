import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englify_app/models/quiz_model.dart';

class QuizService {
  final _firestore = FirebaseFirestore.instance;

  /// 🔹 CREATE QUIZ (Teacher Side)
  Future<void> createQuiz(QuizModel quiz) async {
    // Structure: classes → classId → lessons → lessonId → quizzes → quizId
    await _firestore
        .collection('classes')
        .doc(quiz.classId)
        .collection('lessons')
        .doc(quiz.lessonId)
        .collection('quizzes')
        .add(quiz.toMap());
  }

  /// 🔹 GET QUIZ QUESTIONS (Student Side)
  Future<List<QuizQuestion>> getQuizQuestions({
    required String classId,
    required String lessonId,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('classes')
          .doc(classId)
          .collection('lessons')
          .doc(lessonId)
          .collection('quizzes')
          .orderBy('createdAt', descending: false)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return [];

      final data = snapshot.docs.first.data();

      final questionsData = data['questions'] as List<dynamic>;

      return questionsData
          .map((q) => QuizQuestion.fromMap(q as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Failed to fetch quiz questions: $e');
      return [];
    }
  }
}