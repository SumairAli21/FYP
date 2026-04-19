import 'package:englify_app/UI/views/teacher_flow/teacher_dashboard/teacher_dashboad_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TeacherDashboardView extends StatelessWidget {
  const TeacherDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TeacherDashboadViewmodel>.reactive(
      viewModelBuilder: () => TeacherDashboadViewmodel(),
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
                child: Container(color: Colors.grey.withOpacity(0.1)),
              ),
            ],
          ),
        );
      },
    );
  }
}
