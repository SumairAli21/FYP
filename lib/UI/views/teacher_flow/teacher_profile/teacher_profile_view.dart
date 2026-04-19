import 'package:englify_app/UI/views/teacher_flow/teacher_profile/teacher_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TeacherProfileView extends StatelessWidget {
  const TeacherProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TeacherProfileViewmodel>.reactive(
      viewModelBuilder: () => TeacherProfileViewmodel(),
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
