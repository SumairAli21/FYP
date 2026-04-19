import 'package:englify_app/UI/views/student_flow/student_fav/student_fav_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StudentFavView extends StatelessWidget {
  const StudentFavView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudentFavViewmodel>.reactive(
      viewModelBuilder: () => StudentFavViewmodel(),
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
