import 'package:englify_app/UI/views/student_flow/quiz_attempt/quiz_attempt_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class QuizAttemptView extends StatelessWidget {
  final String classId;
  final String lessonId;
  final String lessonTitle;

  const QuizAttemptView({
    super.key,
    required this.classId,
    required this.lessonId,
    required this.lessonTitle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    return ViewModelBuilder<QuizAttemptViewmodel>.reactive(
      viewModelBuilder: () => QuizAttemptViewmodel(
        classId: classId,
        lessonId: lessonId,
        lessonTitle: lessonTitle,
      ),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              // ── Background
              Positioned.fill(
                child: Image.asset(
                  'assets/images/dies_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),

              SafeArea(
                child: model.isBusy
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : model.questions.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.quiz_outlined,
                                    color: Colors.white70, size: 64),
                                const SizedBox(height: 16),
                                const Text(
                                  'No quiz available for this lesson',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 16),
                                ),
                                const SizedBox(height: 20),
                                TextButton(
                                  onPressed: model.onBack,
                                  child: const Text('Go Back',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          )
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ── Top bar
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: isLandscape ? 6 : 12,
                                ),
                                child: Row(
                                  children: [
                                    // Points badge
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/coins.png',
                                            height: 18,
                                            width: 18,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${model.earnedPoints}/${model.totalPoints}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),

                                    // Info button
                                    GestureDetector(
                                      onTap: () {}, // bad mein implement
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.info_outline,
                                          color: Color(0xFF2F6BFF),
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // ── Feedback bar
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: model.feedbackMessage.isEmpty ? 0 : 40,
                                width: double.infinity,
                                color: model.isAnswerRevealed
                                    ? (model.isCorrectAnswer
                                        ? Colors.green.withOpacity(0.9)
                                        : Colors.red.withOpacity(0.9))
                                    : Colors.transparent,
                                child: model.feedbackMessage.isEmpty
                                    ? null
                                    : Center(
                                        child: Text(
                                          model.feedbackMessage,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                              ),

                              // ── Question content
                              Expanded(
                                child: SingleChildScrollView(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isLandscape ? 40 : 20,
                                    vertical: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Question type label
                                      const Text(
                                        'CHOOSE THE CORRECT ANSWER',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                          fontFamily: 'heading',
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      const SizedBox(height: 8),

                                      // Question text
                                      Text(
                                        model.currentQuestion?.questionText ??
                                            '',
                                        style: TextStyle(
                                          fontSize: isLandscape ? 16 : 18,
                                          color:
                                              Colors.white.withOpacity(0.85),
                                          height: 1.4,
                                        ),
                                      ),
                                      const SizedBox(height: 20),

                                      // ── Options
                                      ...List.generate(
                                        model.currentQuestion?.options.length ??
                                            0,
                                        (oIndex) {
                                          final option = model.currentQuestion!
                                              .options[oIndex];
                                          final isSelected =
                                              model.selectedOptionIndex ==
                                                  oIndex;
                                          final isRevealed =
                                              model.isAnswerRevealed;

                                          Color bgColor = Colors.white
                                              .withOpacity(0.92);
                                          Color textColor = Colors.black87;
                                          Color borderColor =
                                              Colors.transparent;

                                          if (isRevealed) {
                                            if (option.isCorrect) {
                                              // correct answer green
                                              bgColor = Colors.green.shade400;
                                              textColor = Colors.white;
                                              borderColor =
                                                  Colors.green.shade700;
                                            } else if (isSelected &&
                                                !option.isCorrect) {
                                              // wrong selected red
                                              bgColor = Colors.red.shade300;
                                              textColor = Colors.white;
                                              borderColor =
                                                  Colors.red.shade700;
                                            }
                                          } else if (isSelected) {
                                            // selected but not revealed
                                            borderColor =
                                                const Color(0xFF2F6BFF);
                                            bgColor = Colors.white;
                                          }

                                          return GestureDetector(
                                            onTap: () =>
                                                model.selectOption(oIndex),
                                            child: AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              margin: const EdgeInsets.only(
                                                  bottom: 12),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 14,
                                              ),
                                              decoration: BoxDecoration(
                                                color: bgColor,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                  color: borderColor,
                                                  width: 2,
                                                ),
                                              ),
                                              child: Text(
                                                option.text,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: textColor,
                                                  fontWeight: isSelected
                                                      ? FontWeight.w600
                                                      : FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // ── Continue button
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  20,
                                  0,
                                  20,
                                  isLandscape ? 12 : 24,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: isLandscape ? 42 : 52,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          model.selectedOptionIndex == null
                                              ? Colors.grey
                                              : const Color(0xFF2F6BFF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(14),
                                      ),
                                      elevation: 0,
                                    ),
                                    onPressed: model.selectedOptionIndex == null
                                        ? null
                                        : () => model.onContinue(context),
                                    // ── Continue button
child: Text(
  // Last question hai aur answer reveal ho chuka → SUBMIT
  model.isLastQuestion && model.isAnswerRevealed
      ? 'SUBMIT'
      : 'CONTINUE',
  style: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: Colors.white,
    letterSpacing: 1.5,
    fontFamily: 'button',
  ),
),
                                  ),
                                ),
                              ),
                            ],
                          ),
              ),
            ],
          ),
        );
      },
    );
  }
}