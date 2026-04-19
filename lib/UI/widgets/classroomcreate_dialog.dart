// lib/UI/widgets/classroom_success_dialog.dart
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
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2F6BFF).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.celebration,
                color: Color(0xFF2F6BFF),
                size: 60,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Title
            const Text(
              "Classroom Created\nSuccessfully!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "heading",
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Subtitle
            const Text(
              "Share the class code with your students\nto get started.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Copy Code Button
            SizedBox(
              width: double.infinity,
              height: 50,
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
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Done Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                onPressed: onDismiss,
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Done",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2F6BFF),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}