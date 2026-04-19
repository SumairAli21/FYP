import 'package:englify_app/UI/views/privecy&policy/privecyandpolicy_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PrivecyandpolicyView extends StatelessWidget {
  const PrivecyandpolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => PrivecyandpolicyViewmodel(), 
      builder: (context,model,child){
        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/dies_logo.png'), // Tumhari image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(0.1),
                      Colors.grey.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Padding(padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: model.onback,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.arrow_back,color: Colors.black,),
                          ),
                        ),
                        Expanded(
                          child:Center(
                            child: Text(
                               "Privacy Policy",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          )
                           ),
                          
                      ],
                    ),
                    SizedBox(height: 5,),
                    Container(
                            height: 2,
                            width: double.infinity,
                            color: const Color.fromARGB(59, 255, 255, 255),
                          ),
                          SizedBox(height: 15,),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                  "Privacy Policy",
                                    style: TextStyle(
                                      fontFamily: "heading",
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Text(
                                      "Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information when you use our application.",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  _buildSection(
                                "1. Information We Collect",
                                "We may collect personal information such as your name, email address, and usage data to improve app functionality and user experience.",
                              ),
                              _buildSection(
                                "2. How We Use Your Information",
                                "Your information is used to:\n• Provide and improve our services\n• Personalize your experience\n• Communicate important updates and notifications",
                              ),
                              _buildSection(
                                "3. Data Protection",
                                "We take appropriate security measures to protect your personal data from unauthorized access, alteration, or disclosure.",
                              ),
                              _buildSection(
                                "4. Data Sharing",
                                "We do not sell or share your personal information with third parties, except when required by law or to provide essential services.",
                              ),
                              _buildSection(
                                "5. Cookies & Tracking",
                                "The app may use cookies or similar technologies to analyze usage and improve performance.",
                              ),
                              _buildSection(
                                "6. User Rights",
                                "You have the right to access, update, or request deletion of your personal information at any time.",
                              ),
                              _buildSection(
                                "7. Children's Privacy",
                                "This app is not intended for users under the age of 13. We do not knowingly collect data from children.",
                              ),
                              _buildSection(
                                "8. Policy Updates",
                                "We may update this Privacy Policy from time to time. Any changes will be reflected within the app.",
                              ),
                              _buildSection(
                                "9. Contact Us",
                                "If you have any questions or concerns about this Privacy Policy, please contact us through the app's support section.",
                              ),
                                ],
                              ),
                            )
                            )
                  ],
                ),
                )

                ),
            ],
          ),
        );
      }
      );
  }
}
Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w400
           ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
             fontSize: 14,
             color: Colors.white,
             fontWeight: FontWeight.w400
            ),
          ),
        ],
      ),
    );
  }
