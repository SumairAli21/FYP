import 'package:englify_app/UI/views/teacher_flow/teacher_tracker/teacher_tracker_viewemodel.dart';
import 'package:englify_app/services/tracker_service.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TeacherTrackerView extends StatelessWidget {
  const TeacherTrackerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TeacherTrackerViewmodel>.reactive(
      viewModelBuilder: () => TeacherTrackerViewmodel(),
      onViewModelReady: (model) => model.init(),
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
                    // ── Header
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.rs(16),
                          vertical: context.rs(14)),
                      child: Column(
                        children: [
                          Text(
                            'Quiz Tracker',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: context.rf(20),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: context.rs(2)),
                          Text(
                            'Students who attempted your quizzes',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: context.rf(12)),
                          ),
                        ],
                      ),
                    ),

                    // ── Body
                    Expanded(
                      child: model.isBusy
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            )
                          : RefreshIndicator(
                              onRefresh: model.refresh,
                              child: model.students.isEmpty
                                  ? ListView(
                                      children: [
                                        SizedBox(
                                            height:
                                                context.heightPercent(28)),
                                        Center(
                                          child: Text(
                                            'No quiz attempts yet.',
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: context.rf(15)),
                                          ),
                                        ),
                                        SizedBox(height: context.rs(6)),
                                        Center(
                                          child: Text(
                                            'Pull down to refresh.',
                                            style: TextStyle(
                                                color: Colors.white38,
                                                fontSize: context.rf(12)),
                                          ),
                                        ),
                                      ],
                                    )
                                  : ListView.builder(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: context.rs(16),
                                          vertical: context.rs(8)),
                                      itemCount: model.students.length,
                                      itemBuilder: (context, index) {
                                        final student =
                                            model.students[index];
                                        return _StudentTrackerCard(
                                          student: student,
                                          onTap: () =>
                                              model.onStudentTap(student),
                                        );
                                      },
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

class _StudentTrackerCard extends StatelessWidget {
  final StudentTrackerSummary student;
  final VoidCallback onTap;

  const _StudentTrackerCard({required this.student, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final avg = student.averagePercent.round();

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
            CircleAvatar(
              radius: context.rs(32),
              backgroundColor: Colors.grey.shade200,
              backgroundImage: student.profileImage.isNotEmpty
                  ? NetworkImage(student.profileImage)
                  : null,
              child: student.profileImage.isEmpty
                  ? Icon(Icons.person,
                      color: Colors.grey, size: context.rs(30))
                  : null,
            ),
            SizedBox(width: context.rs(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    student.studentName,
                    style: TextStyle(
                      fontSize: context.rf(16),
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: context.rs(8)),
                  Row(
                    children: [
                      _TrackerChip(
                        icon: Icons.quiz_rounded,
                        color: const Color(0xFF2F6BFF),
                        label:
                            '${student.quizzesAttempted} ${student.quizzesAttempted == 1 ? 'quiz' : 'quizzes'}',
                      ),
                      SizedBox(width: context.rs(10)),
                      _TrackerChip(
                        icon: Icons.trending_up_rounded,
                        color: trackerScoreColor(avg.toDouble()),
                        label: 'Avg $avg%',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                color: Colors.grey, size: context.rs(22)),
          ],
        ),
      ),
    );
  }
}

class _TrackerChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _TrackerChip({
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: context.rs(16)),
        SizedBox(width: context.rs(4)),
        Text(
          label,
          style: TextStyle(fontSize: context.rf(12), color: Colors.black54),
        ),
      ],
    );
  }
}

/// Shared score → colour mapping for the quiz-tracker flow.
Color trackerScoreColor(double percent) {
  if (percent >= 75) return const Color(0xFF22A45D); // green
  if (percent >= 40) return const Color(0xFFEAA800); // amber
  return const Color(0xFFE5484D); // red
}
