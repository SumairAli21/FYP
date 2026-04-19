import 'package:flutter/material.dart';

class ClassroomCard extends StatelessWidget {
  final String classroomName;
  final String classroomId;
  final String? imageUrl; // ✅ Make sure this parameter exists
  final VoidCallback onTap;

  const ClassroomCard({
    Key? key,
    required this.classroomName,
    required this.classroomId,
    this.imageUrl, // ✅ Optional parameter
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
              // ✅ Show image if available, else BLACK
              if (imageUrl != null && imageUrl!.isNotEmpty)
                Positioned.fill(
                  child: Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        print("✅ Image loaded: $imageUrl");
                        return child;
                      }
                      print("⏳ Loading image: ${loadingProgress.cumulativeBytesLoaded}/${loadingProgress.expectedTotalBytes}");
                      return Container(
                        color: Colors.grey.shade300,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                            color: Color(0xFF2F6BFF),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      print("❌ Image load error: $error");
                      print("URL: $imageUrl");
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

              // Class name overlay
              Positioned(
                bottom: 14,
                left: 14,
                right: 14,
                child: Container(
                  margin: EdgeInsets.all(8),
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      classroomName.toUpperCase(),
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