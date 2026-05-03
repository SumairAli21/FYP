import 'package:englify_app/UI/views/teacher_flow/std_detail/std_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StudentDetailView extends StatelessWidget {
  final String teacherId;
  final String studentId;

  const StudentDetailView({
    super.key,
    required this.teacherId,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudentDetailViewModel>.reactive(
      viewModelBuilder: () => StudentDetailViewModel(
        teacherId: teacherId,
        studentId: studentId,
      ),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              // Background
              Positioned.fill(
                child: Image.asset(
                  'assets/images/dies_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(.25)),
              ),

              SafeArea(
                child: model.isBusy
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white))
                    : model.student == null
                        ? const Center(
                            child: Text("No Data Found",
                                style: TextStyle(color: Colors.white)))
                        : SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Column(
                              children: [
                                // ── Header
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: model.backToDashboard,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.arrow_back,
                                            color: Colors.black),
                                      ),
                                    ),
                                    const Expanded(
                                      child: Center(
                                        child: Text(
                                          "Student Profile",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 40),
                                  ],
                                ),

                                const SizedBox(height: 20),

                                // ── Profile Card
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: Row(
                                    children: [
                                      // ✅ radius 42
                                      CircleAvatar(
                                        radius: 42,
                                        backgroundColor: Colors.grey.shade200,
                                        backgroundImage: model.student!
                                                .profileImage.isNotEmpty
                                            ? NetworkImage(
                                                model.student!.profileImage)
                                            : null,
                                        child: model.student!.profileImage
                                                .isEmpty
                                            ? const Icon(Icons.person,
                                                size: 36)
                                            : null,
                                      ),

                                      const SizedBox(width: 14),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              model.student!.name,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            if (model.student!.location
                                                .isNotEmpty)
                                              Text(
                                                model.student!.location,
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                // ✅ Level with bar chart icon
                                                _InfoChip(
                                                  icon:
                                                      Icons.bar_chart_rounded,
                                                  color:
                                                      const Color(0xFF2F6BFF),
                                                  label:
                                                      "Lvl ${model.student!.level}",
                                                ),
                                                const SizedBox(width: 10),
                                                // ✅ Points with coins image
                                                _CoinsChip(
                                                    points: model
                                                        .student!.totalPoints),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 18),

                                // ── Stats Grid — each card has its own icon
                                GridView.count(
                                  shrinkWrap: true,
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 14,
                                  crossAxisSpacing: 14,
                                  childAspectRatio: 1.1,
                                  children: [
                                    // Lessons Done
                                    _StatCard(
                                      value:
                                          "${model.student!.completedLessons}/${model.student!.totalLessons}",
                                      label: "Lessons Done",
                                      icon: Icons.menu_book_rounded,
                                      iconColor: const Color(0xFF7C3AED),
                                    ),
                                    // Performance
                                    _StatCard(
                                      value:
                                          "${model.student!.performance.toStringAsFixed(0)}%",
                                      label: "Performance",
                                      icon: Icons.star_rounded,
                                      iconColor: const Color(0xFF16A34A),
                                    ),
                                    // Attendance
                                    _StatCard(
                                      value:
                                          "${model.student!.attendancePercent.toStringAsFixed(0)}%",
                                      label: "Attendance",
                                      icon: Icons.group_rounded,
                                      iconColor: const Color(0xFF9B59B6),
                                    ),
                                    // Avg Score
                                    _StatCard(
                                      value:
                                          "${model.student!.averageScore.toStringAsFixed(0)}%",
                                      label: "Avg Score",
                                      iconWidget: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF27AE60),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Text(
                                          'A+',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 18),

                                // ── Activity Summary
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2F6BFF),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "ACTIVITY SUMMARY",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      _summaryRow(
                                        Icons.check_circle_outline_rounded,
                                        "Lessons Completed",
                                        model.student!.completedLessons
                                            .toString(),
                                      ),
                                      _summaryRow(
                                        Icons.quiz_outlined,
                                        "Quizzes Attempted",
                                        model.student!.totalQuizAttempts
                                            .toString(),
                                      ),
                                      _summaryRow(
                                        Icons.emoji_events_outlined,
                                        "First Attempt Pass",
                                        model.student!.firstTimeAttempts
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 28),

                                // ── Back button
                                SizedBox(
                                  width: double.infinity,
                                  height: 52,
                                  child: ElevatedButton(
                                    onPressed: model.backToDashboard,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color(0xFF2F6BFF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      "BACK TO DASHBOARD",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'heading',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),
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

  // ── Summary row with icon
  Widget _summaryRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stat Card with icon on top
class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData? icon;
  final Color? iconColor;
  final Widget? iconWidget; // for custom widget like A+ badge

  const _StatCard({
    required this.value,
    required this.label,
    this.icon,
    this.iconColor,
    this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon or custom widget
          if (iconWidget != null)
            iconWidget!
          else if (icon != null)
            Icon(icon, color: iconColor, size: 30),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Info chip (level etc.)
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

// ✅ Coins chip with image asset
class _CoinsChip extends StatelessWidget {
  final int points;
  const _CoinsChip({required this.points});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/coins.png',
          height: 16,
          width: 16,
        ),
        const SizedBox(width: 4),
        Text(
          '$points Points',
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}