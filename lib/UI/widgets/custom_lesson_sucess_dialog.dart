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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
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

            
            const Text(
              "Lesson Created\nSuccessfully!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "heading",
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            
            const Text(
              "Share lesson with your students to get started.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24),

            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F6BFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: onDismiss,
                child: const Text(
                  "Back to classroom",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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