import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';

class LessonSuccessDialog extends StatelessWidget {
  final VoidCallback onDismiss;

  const LessonSuccessDialog({
    super.key,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.rs(24), vertical: context.rs(32)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Container(
                padding: EdgeInsets.all(context.rs(16)),
                decoration: BoxDecoration(
                  color: const Color(0xFF2F6BFF).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.celebration,
                  color: const Color(0xFF2F6BFF),
                  size: context.rs(60),
                ),
              ),
              SizedBox(height: context.rs(20)),


              Text(
                "Lesson Created\nSuccessfully!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "heading",
                  fontSize: context.rf(22),
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: context.rs(10)),


              Text(
                "Share lesson with your students to get started.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.rf(14),
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: context.rs(24)),


              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F6BFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: context.rs(14)),
                  ),
                  onPressed: onDismiss,
                  child: Text(
                    "Back to classroom",
                    style: TextStyle(
                      fontSize: context.rf(16),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}