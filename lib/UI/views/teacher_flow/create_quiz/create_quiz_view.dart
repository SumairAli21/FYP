import 'package:englify_app/UI/views/teacher_flow/create_quiz/create_quiz_viewmodel.dart';
import 'package:englify_app/UI/widgets/reusable_button_white.dart';
import 'package:englify_app/UI/widgets/reusable_elevated_blue_button.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CreateQuizView extends StatelessWidget {
  final String classid;
  final String lessonid;
  final String lessontitle;

  const CreateQuizView({
    super.key,
    required this.classid,
    required this.lessonid,
    required this.lessontitle,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.isLandscape;

    return ViewModelBuilder<CreateQuizViewmodel>.reactive(
      viewModelBuilder: () => CreateQuizViewmodel(
        classId: classid,
        lessonId: lessonid,
        lessonTitle: lessontitle,
      ),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF2F4F8),
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/dies_logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.35),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    // ── Fixed header
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: isLandscape ? 6 : 12,
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: isLandscape ? 4 : 15),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: model.onBack,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.arrow_back,
                                      color: Colors.black, size: 20),
                                ),
                              ),
                              SizedBox(width: context.rs(16)),
                              Expanded(
                                child: Text(
                                  'Create Quiz',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: context.rf(18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 2,
                            width: double.infinity,
                            color: const Color.fromARGB(90, 255, 255, 255),
                          ),
                        ],
                      ),
                    ),

                    // ── Scrollable questions list
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.fromLTRB(
                          16,
                          8,
                          16,
                          isLandscape ? 8 : 16,
                        ),
                        controller: model.scrollController,
                        itemCount: model.questions.length,
                        itemBuilder: (context, qindex) {
                          return _buildQuestionCard(
                            context,
                            model,
                            qindex,
                            model.questions[qindex],
                            isLandscape,
                          );
                        },
                      ),
                    ),

                    // ── Bottom buttons
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        16,
                        0,
                        16,
                        isLandscape ? 8 : 16,
                      ),
                      child: Column(
                        children: [
                          AppButtonWhite(
                            title: "Add New Question",
                            onTap: () => model.addQuestion(context),
                          ),
                          SizedBox(height: context.rs(12)),
                          SizedBox(
                            width: double.infinity,
                            height: context.rs(52),
                            child: ElevatedButton(
                              onPressed: model.canPublish
                                  ? () => model.publishQuiz(context)
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: model.quizAlreadyCreated
                                    ? Colors.grey.shade600
                                    : const Color(0xFF2F6BFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (model.isBusy) ...[
                                    const SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation(Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                  ],
                                  Text(
                                    model.quizAlreadyCreated
                                        ? "Quiz Already Created ✓"
                                        : "Publish Quiz",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: context.rf(18),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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

Widget _buildQuestionCard(
  BuildContext context,
  CreateQuizViewmodel model,
  int qIndex,
  QuestionForm question,
  bool isLandscape,
) {
  return Container(
    // ✅ fixed height hata di — content ke hisab se height
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.white, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Question ${qIndex + 1}',
              style: TextStyle(
                fontSize: context.rf(13),
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            if (model.questions.length > 1)
              GestureDetector(
                onTap: () => model.removeQuestion(qIndex),
                child: Container(
                  height: context.rs(44),
                  width: context.rs(44),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: Center(
                    child: Icon(Icons.delete_outlined,
                        color: Colors.white, size: context.rs(26)),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: context.rs(12)),

        // Question field
        TextField(
          cursorColor: Colors.black,
          controller: question.questionController,
          onChanged: (_) => model.notifyListeners(),
          maxLines: 2,
          minLines: 1,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Enter your question here....',
            hintStyle:
                TextStyle(color: Colors.black, fontSize: context.rf(14)),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  const BorderSide(color: Colors.white, width: 1.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  const BorderSide(color: Colors.white, width: 1.5),
            ),
            contentPadding: EdgeInsets.symmetric(
                horizontal: context.rs(16), vertical: context.rs(12)),
          ),
        ),
        SizedBox(height: context.rs(12)),

        // Options
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: question.options.length,
          itemBuilder: (context, oIndex) {
            final option = question.options[oIndex];
            return Padding(
              padding: EdgeInsets.only(bottom: context.rs(8)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.black,
                      controller: option.controller,
                      onChanged: (_) => model.notifyListeners(),
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: GestureDetector(
                          onTap: () =>
                              model.selectCorrectAnswer(qIndex, oIndex),
                          child: Padding(
                            padding: EdgeInsets.all(context.rs(12)),
                            child: Container(
                              height: context.rs(20),
                              width: context.rs(20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: option.isCorrect
                                      ? Colors.green
                                      : Colors.grey,
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: option.isCorrect
                                  ? Center(
                                      child: Container(
                                        height: context.rs(10),
                                        width: context.rs(10),
                                        decoration: const BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        hintText:
                            'Option ${String.fromCharCode(65 + oIndex)}',
                        hintStyle: TextStyle(
                            color: Colors.black, fontSize: context.rf(14)),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Colors.white, width: 1.2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Colors.white, width: 1.5),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: context.rs(14),
                            vertical: context.rs(10)),
                      ),
                    ),
                  ),
                  SizedBox(width: context.rs(8)),
                  GestureDetector(
                    onTap: () =>
                        model.removeOption(qIndex, oIndex, context),
                    child: Container(
                      height: context.rs(44),
                      width: context.rs(44),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: Center(
                        child: Icon(Icons.delete_outlined,
                            color: Colors.white, size: context.rs(26)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        SizedBox(height: context.rs(12)),

        // Add option
        GestureDetector(
          onTap: () => model.addOption(qIndex, context),
          child: Row(
            children: [
              Icon(Icons.add,
                  color: const Color(0xFF2F6BFF), size: context.rs(25)),
              SizedBox(width: context.rs(4)),
              Text(
                'Add option',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: context.rf(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: context.rs(8)),

        // Required toggle
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.rs(10)),
          child: Row(
            children: [
              Text(
                'Required',
                style: TextStyle(
                  fontSize: context.rf(14),
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: question.isRequired,
                  onChanged: (_) => model.toggleRequired(qIndex),
                  thumbColor:
                      MaterialStateProperty.all(Colors.white),
                  trackColor:
                      MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Color(0xFF2F6BFF);
                    }
                    return Colors.grey.shade400;
                  }),
                ),
              ),
            ],
          ),
        ),

        // Timer toggle
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.rs(10)),
          child: Row(
            children: [
              Text(
                'Timer',
                style: TextStyle(
                  fontSize: context.rf(14),
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: question.timerEnabled,
                  onChanged: (_) => model.toggleTimer(qIndex),
                  thumbColor:
                      MaterialStateProperty.all(Colors.white),
                  trackColor:
                      MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Color(0xFF2F6BFF);
                    }
                    return Colors.grey.shade400;
                  }),
                ),
              ),
            ],
          ),
        ),

        if (question.timerEnabled) ...[
          SizedBox(height: context.rs(12)),
          TextField(
            cursorColor: Colors.black,
            controller: question.timerController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: "Seconds (15)",
              hintStyle: TextStyle(
                  color: Colors.black54, fontSize: context.rf(14)),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                    color: Colors.black, width: 1.2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                    color: Colors.black, width: 1.5),
              ),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: context.rs(16), vertical: context.rs(12)),
            ),
          ),
        ],
      ],
    ),
  );
}