import 'package:englify_app/UI/views/student_flow/select_lesson/std_select_lesson_viewmodel.dart';
import 'package:englify_app/UI/widgets/animated_lessoncard.dart';
import 'package:englify_app/models/lesson_data_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StdSelectLessonView extends StatelessWidget {
  final LessonData lesson;
  final Map<String, dynamic> classroom;
  StdSelectLessonView({
    super.key,
    required this.lesson,
    required this.classroom,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final islandscape = size.width > size.height;
    return ViewModelBuilder<StdSelectLessonViewmodel>.reactive(
      viewModelBuilder: () =>
          StdSelectLessonViewmodel(lesson: lesson, classrom: classroom),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/dies_logo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black.withOpacity(0.35),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: islandscape ? 6 : 12,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Image.asset(
                              'assets/images/applogo.png',
                              height: islandscape ? 65 : 60,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.4),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/coins.png',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 3),
                                Text(
                                  model.scoretext,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: islandscape
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: AnimatedLessonCard(
                                        imageUrl: model.imageurl,
                                        lessonTitle: model.lessonname,
                                        isLandscape: islandscape,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 24,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          _builstartquizbutton(model),
                                          SizedBox(height: 15),
                                          _readtheorybutton(model),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Spacer(),
                                  Center(
                                    child: AnimatedLessonCard(
                                      imageUrl: model.imageurl,
                                      lessonTitle: model.lessonname,
                                      isLandscape: islandscape,
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(24, 0, 24, 40),
                                    child: Column(
                                      children: [
                                        _builstartquizbutton(model),
                                        SizedBox(height: 15),
                                        _readtheorybutton(model),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _builstartquizbutton(StdSelectLessonViewmodel model) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: model.isQuizAttempted
              ? Colors
                    .grey // ← attempted = grey
              : const Color(0xFF2F6BFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: model.isQuizAttempted
            ? null // ← disable
            : model.gotoattemptQuiz,
        child: Text(
          model.isQuizAttempted
              ? 'Already Attempted ✓' // ← text change
              : 'START QUIZ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'button',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _readtheorybutton(StdSelectLessonViewmodel model) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.white, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: model.gotolessondetail,
        child: Text(
          'READ THEORY',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'button',
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
