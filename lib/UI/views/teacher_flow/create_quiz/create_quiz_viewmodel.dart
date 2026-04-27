import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/models/quiz_model.dart';
import 'package:englify_app/services/quiz_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CreateQuizViewmodel extends BaseViewModel {
  final _quizService = locator<QuizService>();
  final _navigationService = locator<NavigationService>();

  final String classId;
  final String lessonId;
  final String lessonTitle;

  CreateQuizViewmodel({
    required this.classId,
    required this.lessonId,
    required this.lessonTitle,
  });

  final ScrollController scrollController = ScrollController();
  final List<QuestionForm> questions = [QuestionForm()];

   bool quizAlreadyCreated = false;

  bool get canPublish => !quizAlreadyCreated && !isBusy;

  static const int maxQuestions = 20;
  static const int maxOptions = 4;
  static const int minOptions = 2;


    Future<void> init() async {
    setBusy(true);

    quizAlreadyCreated = await _quizService.hasQuizForLesson(
      classId: classId,
      lessonId: lessonId,
    );

    setBusy(false);
  }

  bool get _allQuestionsFilled {
    for (final q in questions) {
      if (q.questionController.text.trim().isEmpty) return false;
      for (final o in q.options) {
        if (o.controller.text.trim().isEmpty) return false;
      }
    }
    return true;
  }

  Future<void> addQuestion(BuildContext context) async {
    if (questions.length >= maxQuestions) {
      _showSnack(context, 'Maximum 20 questions allowed');
      return;
    }

    if (!_allQuestionsFilled) {
      _showSnack(context, 'Please fill all questions and options first');
      return;
    }

    questions.add(QuestionForm());
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 100));
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  void removeQuestion(int index) {
    if (questions.length > 1) {
      questions[index].dispose();
      questions.removeAt(index);
      notifyListeners();
    }
  }

  void addOption(int qIndex, BuildContext context) {
    if (questions[qIndex].options.length >= maxOptions) {
      _showSnack(context, 'Maximum 4 options allowed');
      return;
    }
    questions[qIndex].options.add(OptionForm());
    notifyListeners();
  }

  void removeOption(int qIndex, int oIndex, BuildContext context) {
    if (questions[qIndex].options.length <= minOptions) {
      _showSnack(context, 'Minimum 2 options required');
      return;
    }
    questions[qIndex].options[oIndex].dispose();
    questions[qIndex].options.removeAt(oIndex);
    notifyListeners();
  }

  void selectCorrectAnswer(int qIndex, int oIndex) {
    for (int i = 0; i < questions[qIndex].options.length; i++) {
      questions[qIndex].options[i].isCorrect = (i == oIndex);
    }
    notifyListeners();
  }

  void toggleRequired(int qIndex) {
    questions[qIndex].isRequired = !questions[qIndex].isRequired;
    notifyListeners();
  }

  String? _validate() {
    for (int i = 0; i < questions.length; i++) {
      final q = questions[i];
      if (q.questionController.text.trim().isEmpty) {
        return 'Question ${i + 1} text is empty';
      }
      for (int j = 0; j < q.options.length; j++) {
        if (q.options[j].controller.text.trim().isEmpty) {
          return 'Question ${i + 1} - Option ${j + 1} is empty';
        }
      }
      if (!q.options.any((o) => o.isCorrect)) {
        return 'Please select a correct answer for Question ${i + 1}';
      }
    }
    return null;
  }

  Future<void> publishQuiz(BuildContext context) async {
    // ✅ BLOCK IF ALREADY EXISTS
    if (quizAlreadyCreated) {
      _showSnack(context, "Quiz already created for this lesson");
      return;
    }

    final error = _validate();
    if (error != null) {
      _showSnack(context, error);
      return;
    }

    setBusy(true);

    try {
      final quiz = QuizModel(
        classId: classId,
        lessonId: lessonId,
        lessonTitle: lessonTitle,
        createdAt: DateTime.now(),
        questions: questions
            .map((q) => QuizQuestion(
                  questionText: q.questionController.text.trim(),
                  isRequired: q.isRequired,
                  options: q.options
                      .map((o) => QuizOption(
                            text: o.controller.text.trim(),
                            isCorrect: o.isCorrect,
                          ))
                      .toList(),
                ))
            .toList(),
      );

      await _quizService.createQuiz(quiz);

      // ✅ LOCK AFTER CREATE
      quizAlreadyCreated = true;

      setBusy(false);
      notifyListeners();

      if (context.mounted) {
        _showSuccessDialog(context);
      }
    } catch (e) {
      setBusy(false);
      _showSnack(context, 'Failed: $e');
    }
  }


  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🎉', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              const Text(
                'Quiz Created\nSuccessfully!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Share quiz with your students to get started.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[500],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F6BFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _navigationService.back();
                  },
                  child: const Text(
                    'Back to Classroom',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF2F6BFF),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void onBack() => _navigationService.back();

  @override
  void dispose() {
    scrollController.dispose();
    for (final q in questions) {
      q.dispose();
    }
    super.dispose();
  }
}

// ── Form helper classes
class QuestionForm {
  final questionController = TextEditingController();
  bool isRequired = false;
  List<OptionForm> options = [OptionForm(), OptionForm()];

  void dispose() {
    questionController.dispose();
    for (final o in options) o.dispose();
  }
}

class OptionForm {
  final controller = TextEditingController();
  bool isCorrect = false;

  void dispose() => controller.dispose();
}