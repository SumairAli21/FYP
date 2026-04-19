import 'package:englify_app/UI/widgets/reusable_elevated_blue_button.dart';
import 'package:flutter/material.dart';

class OnbordingSlides extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback oncontinue;
  final VoidCallback onskip;
  final int currentIndex;
  final int totalPages;

  const OnbordingSlides({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.oncontinue,
    required this.onskip,
    required this.currentIndex,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: isLandscape
            ? _buildLandscapeLayout(size)
            : _buildPortraitLayout(size),
      ),
    );
  }

  Widget _buildPortraitLayout(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image Section with Skip Button
        Stack(
          children: [
            Image.asset(
              image,
              width: size.width,
              height: size.height * 0.64,
              fit: BoxFit.cover,
            ),
            // Skip Button
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: onskip,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: "button",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        // Content Section
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontFamily: "heading",
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12),

                // Subtitle
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: "button",
                    fontSize: 14,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),

                Spacer(),

                // ✅ Page Indicators
                _buildPageIndicators(),
                SizedBox(height: 16),

                // Continue Button
                AppButton(
                  title: currentIndex == totalPages - 1
                      ? "Get Started"
                      : "Continue",
                  onTap: oncontinue,
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout(Size size) {
    return Row(
      children: [
        // Image Section
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              Image.asset(
                image,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              // Skip Button
              Positioned(
                top: 16,
                right: 16,
                child: GestureDetector(
                  onTap: onskip,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: "button",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Content Section
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontFamily: "heading",
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: "button",
                    fontSize: 13,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 24),

                // ✅ Page Indicators
                _buildPageIndicators(),
                SizedBox(height: 16),

                AppButton(
                  title: currentIndex == totalPages - 1
                      ? "Get Started"
                      : "Continue",
                  onTap: oncontinue,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ✅ Page Indicator Dots
  Widget _buildPageIndicators() {
    return Row(
      children: List.generate(
        totalPages,
        (index) => Container(
          margin: EdgeInsets.only(right: 8),
          width: currentIndex == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? Color(0xFF2F6BFF)
                : Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}