import 'package:englify_app/UI/views/auth/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset("assets/images/auth.png", fit: BoxFit.cover),
              ),

              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.15),
                        Colors.black.withOpacity(0.65),
                      ],
                    ),
                  ),
                ),
              ),

              // Logo
              Positioned(
                top: size.height * 0.06,
                left: 5,
                child: Image.asset("assets/images/applogo.png", height: 65),
              ),

              // Buttons Section
              Positioned(
                left: 23,
                right: 23,
                bottom: 70,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ✅ Apple Sign-In Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: model.isBusy ? null : model.signInWithApple,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2F6BFF),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (model.isBusy) ...[
                              const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                            ] else ...[
                              Icon(Icons.apple, size: 30, color: Colors.white),
                              const SizedBox(width: 12),
                            ],
                            Text(
                              model.isBusy
                                  ? "Signing in..."
                                  : "Continue with Apple",
                              style: TextStyle(
                                fontFamily: "button",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),

                    // ✅ Google Sign-In Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: model.isBusy ? null : model.signInWithGoogle,
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
                            if (model.isBusy) ...[
                              const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                            ] else ...[
                              FaIcon(
                                FontAwesomeIcons.google,
                                size: 28,
                                color: Colors.black,
                              ),
                              const SizedBox(width: 12),
                            ],
                            Text(
                              model.isBusy
                                  ? "Signing in..."
                                  : "Continue with Gmail",
                              style: TextStyle(
                                fontFamily: "button",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),

                    // ✅ Email Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: model.isBusy
                            ? null
                            : model.continuewithemail,
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
                            Icon(Icons.email, size: 30, color: Colors.black),
                            const SizedBox(width: 12),
                            Text(
                              "Continue with Email",
                              style: TextStyle(
                                fontFamily: "button",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ✅ Error Message Display
                    if (model.errorMessage != null)
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.red.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red.shade300,
                                size: 20,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  model.errorMessage!,
                                  style: TextStyle(
                                    color: Colors.red.shade100,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    SizedBox(height: 20),

                    // Terms & Privacy
                    Column(
                      children: [
                        Text(
                          "By continuing you agree to our",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "button",
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: model.isBusy
                              ? null
                              : model.onnavigatetoprivecy,
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "privacy policy",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: "button",
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Text("and", style: TextStyle(color: Colors.white70)),
                        SizedBox(width: 4),
                        TextButton(
                          onPressed: model.isBusy
                              ? null
                              : model.onnavigatetoterms,
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "Terms of use",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: "button",
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
