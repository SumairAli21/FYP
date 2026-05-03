import 'package:englify_app/UI/views/teacher_flow/std_list/std_viewmodel.dart';
import 'package:englify_app/services/dashboard_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StudentsListView extends StatelessWidget {
  final String teacherId;
  const StudentsListView({super.key, required this.teacherId});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudentsListViewmodel>.reactive(
      viewModelBuilder: () => StudentsListViewmodel(teacherId: teacherId),
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
                    // ── App bar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
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
                          const Expanded(
                            child: Center(
                              child: Text(
                                'Profile',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.tune_rounded,
                                color: Color(0xFF2F6BFF), size: 20),
                          ),
                        ],
                      ),
                    ),

                    // ── List
                    Expanded(
                      child: model.isBusy
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white))
                          : model.students.isEmpty
                              ? const Center(
                                  child: Text('No students yet.',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 15)),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  itemCount: model.students.length,
                                  itemBuilder: (context, index) {
                                    return _StudentCard(
                                      student: model.students[index],
                                      onTap: () => model.onStudentTap(
                                          model.students[index].studentId),
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

// ── Student Card ─────────────────────────────
class _StudentCard extends StatelessWidget {
  final StudentSummary student;
  final VoidCallback onTap;

  const _StudentCard({required this.student, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 8,
                offset: const Offset(0, 3)),
          ],
        ),
        child: Row(
          children: [
            // ✅ radius 42
            CircleAvatar(
              radius: 42,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: student.profileImage.isNotEmpty
                  ? NetworkImage(student.profileImage)
                  : null,
              child: student.profileImage.isEmpty
                  ? const Icon(Icons.person, color: Colors.grey, size: 36)
                  : null,
            ),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    student.classNames.join(', '),
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // ✅ Level chip with bar chart icon
                      _InfoChip(
                        icon: Icons.bar_chart_rounded,
                        iconColor: const Color(0xFF2F6BFF),
                        label: 'Lvl ${student.level}',
                      ),
                      const SizedBox(width: 12),
                      // ✅ Points chip with coins image
                      _CoinsChip(points: student.totalPoints),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: Colors.grey, size: 22),
          ],
        ),
      ),
    );
  }
}

// ── Level / generic icon chip ────────────────
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;

  const _InfoChip(
      {required this.icon, required this.iconColor, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 16),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }
}

// ✅ Coins chip — uses coins.png image asset
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
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }
}