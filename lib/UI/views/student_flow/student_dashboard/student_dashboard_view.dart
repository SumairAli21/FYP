import 'dart:math' as math;

import 'package:englify_app/UI/views/student_flow/student_dashboard/studen_dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StudentDashboardView extends StatelessWidget {
  const StudentDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudentDashboardViewmodel>.reactive(
      viewModelBuilder: () => StudentDashboardViewmodel(),
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
                child: Container(color: Colors.black.withOpacity(0.25)),
              ),

              SafeArea(
                child: model.isBusy
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white))
                    : SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Top bar
                            _buildTopBar(),
                            const SizedBox(height: 20),

                            // ── 4 stat cards
                            _buildStatsGrid(model),
                            const SizedBox(height: 20),

                            // ── Continue Learning (top class)
                            _buildContinueLearning(model),
                            const SizedBox(height: 20),

                            // ── Rewards & Motivation
                            _buildRewards(model),
                            const SizedBox(height: 24),
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

  // ── Top bar ──────────────────────────────────
  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text(
                  'Welcome back! ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text('👋', style: TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              'Learn and grow daily.',
              style: TextStyle(
                color: Colors.white.withOpacity(0.80),
                fontSize: 13,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.calendar_today_rounded,
            color: Color(0xFF2F6BFF),
            size: 22,
          ),
        ),
      ],
    );
  }

  // ── 2×2 Stats Grid ───────────────────────────
  Widget _buildStatsGrid(StudentDashboardViewmodel model) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: [
        // Level — bar chart icon blue
        _StatCard(
          topWidget: const Icon(
            Icons.bar_chart_rounded,
            color: Color(0xFF2F6BFF),
            size: 36,
          ),
          value: 'Level ${model.level}',
          label: 'Current Level',
        ),
        // Total Points — coins image
        _StatCard(
          topWidget: Image.asset(
            'assets/images/coins.png',
            height: 36,
            width: 36,
          ),
          value: '${model.totalPoints} pts',
          label: 'Total Points',
        ),
        // Lessons Done — book icon purple
        _StatCard(
          topWidget: const Icon(
            Icons.menu_book_rounded,
            color: Color(0xFF7C3AED),
            size: 36,
          ),
          value: '${model.completedLessons}/${model.totalLessons}',
          label: 'Lessons Done',
        ),
        // Performance — star icon green
        _StatCard(
          topWidget: const Icon(
            Icons.star_rounded,
            color: Color(0xFF16A34A),
            size: 36,
          ),
          value: '${model.performance.toStringAsFixed(0)}%',
          label: 'Performance',
        ),
      ],
    );
  }

  // ── Continue Learning ─────────────────────────
  Widget _buildContinueLearning(StudentDashboardViewmodel model) {
    final hasClass = model.topClassName.isNotEmpty;
    final score = model.topClassScore;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CONTINUE LEARNING',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            hasClass
                ? 'Resume and access new levels.'
                : 'No class joined yet.',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              // Pie chart showing top class score
              _PieChart(percentage: score / 100),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (hasClass)
                      Text(
                        model.topClassName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: hasClass ? model.onContinueTap : null,
                      child: Row(
                        children: [
                          Icon(
                            Icons.play_arrow_rounded,
                            color: hasClass
                                ? const Color(0xFF2F6BFF)
                                : Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Continue',
                            style: TextStyle(
                              color: hasClass
                                  ? const Color(0xFF2F6BFF)
                                  : Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
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
        ],
      ),
    );
  }

  // ── Rewards & Motivation ──────────────────────
  Widget _buildRewards(StudentDashboardViewmodel model) {
    // Determine next level milestone
    final nextLevelPoints = model.level * 500;
    final progress = (model.totalPoints % nextLevelPoints) / nextLevelPoints;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF2F6BFF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'REWARDS & MOTIVATION',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 15,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          // Progress bar to next level
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• Level ${model.level + 1} Unlocked at $nextLevelPoints pts',
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: progress.clamp(0.0, 1.0),
                        minHeight: 8,
                        backgroundColor: Colors.white30,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.white),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${model.totalPoints} / $nextLevelPoints pts',
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Stat Card ─────────────────────────────────
class _StatCard extends StatelessWidget {
  final Widget topWidget;
  final String value;
  final String label;

  const _StatCard({
    required this.topWidget,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            topWidget,
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Pie Chart ─────────────────────────────────
class _PieChart extends StatelessWidget {
  final double percentage;
  const _PieChart({required this.percentage});

  @override
  Widget build(BuildContext context) {
    final display = (percentage * 100).toStringAsFixed(0);
    return SizedBox(
      height: 72,
      width: 72,
      child: CustomPaint(
        painter: _PieChartPainter(percentage: percentage),
        child: Center(
          child: Text(
            '$display%',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final double percentage;
  _PieChartPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
    const strokeWidth = 9.0;

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.grey.shade200
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * percentage,
      false,
      Paint()
        ..color = const Color(0xFF2F6BFF)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}