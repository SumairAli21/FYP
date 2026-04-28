

class QuizModel {
  final String classId;
  final String lessonId;
  final String lessonTitle;
  final DateTime createdAt;
  final List<QuizQuestion> questions;

  QuizModel({
    required this.classId,
    required this.lessonId,
    required this.lessonTitle,
    required this.createdAt,
    required this.questions,
  });

  Map<String, dynamic> toMap() {
    return {
      'classId': classId,
      'lessonId': lessonId,
      'lessonTitle': lessonTitle,
      'createdAt': createdAt.toIso8601String(),
      'questions': questions.map((q) => q.toMap()).toList(),
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      classId: map['classId'] ?? '',
      lessonId: map['lessonId'] ?? '',
      lessonTitle: map['lessonTitle'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      questions: (map['questions'] as List<dynamic>)
          .map((q) => QuizQuestion.fromMap(q))
          .toList(),
    );
  }
}

class QuizQuestion {
  final String questionText;
  final bool isRequired;
  final List<QuizOption> options;

  // ── Timer fields
  final bool timerEnabled;
  final int timerSeconds; // default 15

  QuizQuestion({
    required this.questionText,
    required this.isRequired,
    required this.options,
    this.timerEnabled = false,
    this.timerSeconds = 15,
  });

  Map<String, dynamic> toMap() {
    return {
      'questionText': questionText,
      'isRequired': isRequired,
      'timerEnabled': timerEnabled,
      'timerSeconds': timerSeconds,
      'options': options.map((o) => o.toMap()).toList(),
    };
  }

  factory QuizQuestion.fromMap(Map<String, dynamic> map) {
    return QuizQuestion(
      questionText: map['questionText'] ?? '',
      isRequired: map['isRequired'] ?? false,
      timerEnabled: map['timerEnabled'] ?? false,
      timerSeconds: map['timerSeconds'] ?? 15,
      options: (map['options'] as List<dynamic>)
          .map((o) => QuizOption.fromMap(o))
          .toList(),
    );
  }
}

class QuizOption {
  final String text;
  final bool isCorrect;

  QuizOption({required this.text, required this.isCorrect});

  Map<String, dynamic> toMap() => {
        'text': text,
        'isCorrect': isCorrect,
      };

  factory QuizOption.fromMap(Map<String, dynamic> map) {
    return QuizOption(
      text: map['text'] ?? '',
      isCorrect: map['isCorrect'] ?? false,
    );
  }
}