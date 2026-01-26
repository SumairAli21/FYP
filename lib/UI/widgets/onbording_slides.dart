import 'package:englify_app/UI/widgets/reusable_elevated_blue_button.dart';
import 'package:flutter/material.dart';

class OnbordingSlides extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback oncontinue;
  final VoidCallback onskip;

  const OnbordingSlides({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.oncontinue,
    required this.onskip,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  image,
                  width: size.width,
                  height: size.height * 0.68,
                  fit: BoxFit.cover,
                ),
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
                        "skip",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            Padding
            (
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title.toUpperCase(),
              
                style: TextStyle(
                  fontFamily: "heading",
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                
                ),
                
                ),
            ),
            SizedBox(height: 12,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(

                subtitle,
                
                style: TextStyle(
                  fontFamily: "button",
                  fontSize: 14,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              ),
              Spacer(),
              Padding(padding: EdgeInsets.all(16),
              child: appbutton(title : "Continue", onTap: oncontinue),)
          ],
        ),
      ),
    );
  }
}
