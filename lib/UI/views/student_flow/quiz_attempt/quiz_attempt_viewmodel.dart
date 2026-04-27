import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/models/quiz_model.dart';
import 'package:englify_app/services/pints_service.dart';
import 'package:englify_app/services/quiz_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class QuizAttemptViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _quizService = locator<QuizService>();
  final _pointsService = locator<PointsService>();

  final String classId;
  final String lessonId;
  final String lessonTitle;

  QuizAttemptViewmodel({
    required this.classId,
    required this.lessonId,
    required this.lessonTitle,
  });

  // ── Quiz data
  List<QuizQuestion> questions = [];
  int currentIndex = 0;
  int earnedPoints = 0;

  // ── Per question state
  int? selectedOptionIndex;
  bool isAnswerRevealed = false;
  String feedbackMessage = '';

  // ── Points
  int get totalPoints => 100;
  int get pointsPerQuestion =>
      questions.isEmpty ? 0 : (100 / questions.length).round();

  QuizQuestion? get currentQuestion =>
      questions.isEmpty ? null : questions[currentIndex];

  bool get isLastQuestion =>
      questions.isNotEmpty && currentIndex == questions.length - 1;

  bool get isCorrectAnswer {
    if (selectedOptionIndex == null || currentQuestion == null) return false;
    return currentQuestion!.options[selectedOptionIndex!].isCorrect;
  }

  // ── Load quiz from Firestore
  Future<void> init() async {
    setBusy(true);
    try {
      questions = await _quizService.getQuizQuestions(
        classId: classId,
        lessonId: lessonId,
      );
    } catch (e) {
      print('Failed to load quiz: $e');
    }
    setBusy(false);
  }

  // ── Select option
  void selectOption(int index) {
    if (isAnswerRevealed) return; // already revealed — nahi badal sakte
    selectedOptionIndex = index;
    notifyListeners();
  }

  // ── Continue button press
  void onContinue(BuildContext context) async{
    if (selectedOptionIndex == null) return;

    if (!isAnswerRevealed) {
      // ── First press: reveal answer
      isAnswerRevealed = true;

      if (isCorrectAnswer) {
        earnedPoints += pointsPerQuestion;
        feedbackMessage = _getCorrectFeedback();
      } else {
        feedbackMessage = 'Wrong! answer via theory again😜';
      }
      notifyListeners();
    } else {
  // ── Second press: next question or result
  if (isLastQuestion) {
    setBusy(true);         // ← loading show karo submit pe
    notifyListeners();
    await _showResultScreen(context);
    setBusy(false);
    notifyListeners();
  } else {
    currentIndex++;
    selectedOptionIndex = null;
    isAnswerRevealed = false;
    feedbackMessage = '';
    notifyListeners();
  }
}
  }

  String _getCorrectFeedback() {
    final feedbacks = [
      'Fantastic😎',
      'Great job! 🎉',
      'Correct! Keep going 🔥',
      'Awesome! 💪',
      'Well done! ⭐',
    ];
    feedbacks.shuffle();
    return feedbacks.first;
  }

  // ── Show result screen
  Future<void> _showResultScreen(BuildContext context) async {
    // Save points to Firestore
    await _pointsService.savequizresult(
      lessonId: lessonId,
      classId: classId,
      score: earnedPoints,
      totalPoints: totalPoints,
    );

    if (context.mounted) {
      _showResultDialog(context);
    }
  }

  void _showResultDialog(BuildContext context) {
  final bool isPerfect = earnedPoints == totalPoints;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24, // ← sides pe padding
        vertical: 40,   // ← upar neeche padding
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6B2FBF),
              Color(0xFF4A1A8C),
              Color(0xFF2D0F5E),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        // ← SingleChildScrollView wrap karo overflow fix ke liye
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isPerfect ? '😎' : '😢',
                style: const TextStyle(fontSize: 72),
              ),
              const SizedBox(height: 12),

              Text(
                'YOU EARNED $earnedPoints POINTS!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontFamily: 'heading',
                ),
              ),
              const SizedBox(height: 10),

              Text(
                isPerfect
                    ? 'Great start! Let\'s grow together\nand keep learning.'
                    : 'Don\'t worry — progress takes\npractice. Try again and come back stronger 🚀',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.8),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),

              // View Leaderboard
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F6BFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _navigationService.back();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('🏆', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Text(
                        'VIEW LEADERBOARD',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Second button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _navigationService.back();
                  },
                  child: Text(
                    isPerfect ? '▶️ START LEVEL 2' : 'CONTINUE LEVEL 1',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

  void onBack() => _navigationService.back();
}