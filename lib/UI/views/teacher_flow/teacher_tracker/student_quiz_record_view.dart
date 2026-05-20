import 'package:englify_app/UI/views/teacher_flow/teacher_tracker/student_quiz_record_viewmodel.dart';
import 'package:englify_app/UI/views/teacher_flow/teacher_tracker/teacher_tracker_view.dart'
    show trackerScoreColor;
import 'package:englify_app/models/quiz_attempt_model.dart';
import 'package:englify_app/services/tracker_service.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StudentQuizRecordView extends StatelessWidget {
  final StudentTrackerSummary summary;
  const StudentQuizRecordView({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudentQuizRecordViewmodel>.reactive(
      viewModelBuilder: () => StudentQuizRecordViewmodel(summary),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/dies_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.25)),
              ),
              SafeArea(
                child: Column(
                  children: [
                    // ── App bar
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.rs(16),
                          vertical: context.rs(12)),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: model.onBack,
                            child: Container(
                              padding: EdgeInsets.all(context.rs(8)),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.arrow_back,
                                  color: Colors.black, size: context.rs(20)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                model.summary.studentName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: context.rf(20)),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          SizedBox(width: context.rs(36)),
                        ],
                      ),
                    ),

                    // ── Sub-title
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          context.rs(16), 0, context.rs(16), context.rs(8)),
                      child: Text(
                        '${model.attempts.length} '
                        '${model.attempts.length == 1 ? 'quiz' : 'quizzes'} attempted',
                        style: TextStyle(
                            color: Colors.white70, fontSize: context.rf(12)),
                      ),
                    ),

                    // ── Quiz list
                    Expanded(
                      child: model.attempts.isEmpty
                          ? Center(
                              child: Text(
                                'No quiz records.',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: context.rf(15)),
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.rs(16),
                                  vertical: context.rs(8)),
                              itemCount: model.attempts.length,
                              itemBuilder: (context, index) {
                                final attempt = model.attempts[index];
                                return _QuizRecordCard(
                                  attempt: attempt,
                                  onTap: () => model.onQuizTap(attempt),
                                );
                              },
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

class _QuizRecordCard extends StatelessWidget {
  final QuizAttemptRecord attempt;
  final VoidCallback onTap;

  const _QuizRecordCard({required this.attempt, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = trackerScoreColor(attempt.percent);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: context.rs(12)),
        padding: EdgeInsets.symmetric(
            horizontal: context.rs(14), vertical: context.rs(14)),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: context.rs(48),
              height: context.rs(48),
              decoration: BoxDecoration(
                color: const Color(0xFF2F6BFF).withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.assignment_rounded,
                  color: const Color(0xFF2F6BFF), size: context.rs(24)),
            ),
            SizedBox(width: context.rs(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    attempt.lessonTitle,
                    style: TextStyle(
                      fontSize: context.rf(16),
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: context.rs(3)),
                  Text(
                    'Quiz • ${attempt.score}/${attempt.totalPoints} points',
                    style: TextStyle(
                        fontSize: context.rf(12), color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            SizedBox(width: context.rs(8)),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: context.rs(10), vertical: context.rs(6)),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${attempt.percent.round()}%',
                style: TextStyle(
                  fontSize: context.rf(13),
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
            ),
            SizedBox(width: context.rs(4)),
            Icon(Icons.chevron_right_rounded,
                color: Colors.grey, size: context.rs(22)),
          ],
        ),
      ),
    );
  }
}
