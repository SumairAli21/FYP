import 'package:englify_app/UI/views/teacher_flow/teacher_tracker/teacher_tracker_viremodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TeacherTrackerView extends StatelessWidget {
  const TeacherTrackerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TeacherTrackerViremodel>.reactive(
      viewModelBuilder: () => TeacherTrackerViremodel(),
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
