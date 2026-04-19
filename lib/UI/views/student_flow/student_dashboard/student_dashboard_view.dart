import 'package:englify_app/UI/views/student_flow/student_dashboard/studen_dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StudentDashboardView extends StatelessWidget {
  const StudentDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudenDashboardViewmodel>.reactive(
      viewModelBuilder: () => StudenDashboardViewmodel(),
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
              )
            ],
          ),
        );
      },
    );
  }
}
