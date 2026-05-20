// lib/UI/widgets/classroom_success_dialog.dart
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClassroomSuccessDialog extends StatelessWidget {
  final String classCode;
  final VoidCallback onDismiss;

  const ClassroomSuccessDialog({
    Key? key,
    required this.classCode,
    required this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.all(context.rs(24)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon
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

              // Title
              Text(
                "Classroom Created\nSuccessfully!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "heading",
                  fontSize: context.rf(30),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: context.rs(12)),

              // Subtitle
              Text(
                "Share the class code with your students\nto get started.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.rf(16),
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: context.rs(24)),

              // Copy Code Button
              SizedBox(
                width: double.infinity,
                height: context.rs(50),
                child: ElevatedButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: classCode));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Class code copied to clipboard!"),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F6BFF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Copy Code  $classCode",
                  style: TextStyle(
                    fontSize: context.rf(16),
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              ),

              SizedBox(height: context.rs(12)),

              // Done Button
              SizedBox(
                width: double.infinity,
                height: context.rs(50),
                child: TextButton(
                  onPressed: onDismiss,
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Done",
                    style: TextStyle(
                      fontSize: context.rf(16),
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2F6BFF),
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