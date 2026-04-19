class QuizModel {
  final String? id;
  final String classId;
  final String lessonId;
  final String lessonTitle;
  final List<QuizQuestion> questions;
  final DateTime createdAt;

  QuizModel({
    this.id,
    required this.classId,
    required this.lessonId,
    required this.lessonTitle,
    required this.questions,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
    'classId': classId,
    'lessonId': lessonId,
    'lessonTitle': lessonTitle,
    'questions': questions.map((q) => q.toMap()).toList(),
    'createdAt': createdAt.toIso8601String(),
  };

  factory QuizModel.fromMap(String id, Map<String, dynamic> map) => QuizModel(
    id: id,
    classId: map['classId'] ?? '',
    lessonId: map['lessonId'] ?? '',
    lessonTitle: map['lessonTitle'] ?? '',
    createdAt: DateTime.parse(map['createdAt']),
    questions: (map['questions'] as List<dynamic>)
        .map((q) => QuizQuestion.fromMap(q))
        .toList(),
  );
}

class QuizQuestion {
  final String questionText;
  final List<QuizOption> options;
  final bool isRequired;

  QuizQuestion({
    required this.questionText,
    required this.options,
    this.isRequired = false,
  });

  Map<String, dynamic> toMap() => {
    'questionText': questionText,
    'options': options.map((o) => o.toMap()).toList(),
    'isRequired': isRequired,
  };

  factory QuizQuestion.fromMap(Map<String, dynamic> map) => QuizQuestion(
    questionText: map['questionText'] ?? '',
    isRequired: map['isRequired'] ?? false,
    options: (map['options'] as List<dynamic>)
        .map((o) => QuizOption.fromMap(o))
        .toList(),
  );
}

class QuizOption {
  final String text;
  final bool isCorrect;

  QuizOption({
    required this.text,
    this.isCorrect = false,
  });

  Map<String, dynamic> toMap() => {
    'text': text,
    'isCorrect': isCorrect,
  };

  factory QuizOption.fromMap(Map<String, dynamic> map) => QuizOption(
    text: map['text'] ?? '',
    isCorrect: map['isCorrect'] ?? false,
  );
}