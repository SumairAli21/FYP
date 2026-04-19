import 'package:flutter/material.dart';

class LessonCard extends StatelessWidget {
  final String lessonName;
  final String lessonId;
  final String? imageUrl;
  final VoidCallback onTap;

  const LessonCard({
    Key? key,
    required this.lessonName,
    required this.lessonId,
    this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: Colors.white,
            width: 5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            children: [
              // ✅ Show image if available
              if (imageUrl != null && imageUrl!.isNotEmpty)
                Positioned.fill(
                  child: Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        print("✅ Lesson Image loaded: $imageUrl");
                        return child;
                      }
                      return Container(
                        color: Colors.grey.shade300,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                            color: const Color(0xFF2F6BFF),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      print("❌ Lesson Image load error: $error");
                      return Container(
                        color: Colors.black,
                        child: Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.white.withOpacity(0.3),
                            size: 50,
                          ),
                        ),
                      );
                    },
                  ),
                )
              else
                Container(
                  color: Colors.black,
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.white.withOpacity(0.3),
                      size: 50,
                    ),
                  ),
                ),

              // ✅ Lesson name overlay (same style)
              Positioned(
                bottom: 14,
                left: 14,
                right: 14,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      lessonName.toUpperCase(),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: "heading",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        letterSpacing: 0.5,
                      ),
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
