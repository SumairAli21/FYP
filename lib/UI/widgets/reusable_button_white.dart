import 'package:flutter/material.dart';

class AppButtonWhite extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isLoading;

  const AppButtonWhite({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) ...[
              const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
              const SizedBox(width: 12),
            ],
            Text(
              title,
              style: const TextStyle(
                fontFamily: "button",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
