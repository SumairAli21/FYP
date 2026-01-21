import 'package:englify_app/UI/views/signup/signup_email_view_model.dart';
import 'package:englify_app/UI/widgets/resuale_email_textfeild.dart';
import 'package:englify_app/UI/widgets/reusable_elevated_blue_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Signupemailview extends StatelessWidget {
  const Signupemailview({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<SignupEmailViewModel>.reactive(
      viewModelBuilder: () => SignupEmailViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  SizedBox(height: 20,),
                  Row(
                      children: [
                         IconButton(onPressed: model.onback, icon: Icon(Icons.arrow_back_sharp, color: Colors.white),),
                         SizedBox(width: size.width*0.09,),
                         Center(child: Text("Sign up with Email",
                      style: TextStyle(
                      
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),),)
                      ],
                  ),
                    SizedBox(height: size.height*0.10,),
                    Text(
                      "Email address",
                      style: TextStyle(
                        fontFamily: "button",
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      
                    ),
                    SizedBox(height: 5,),
                    ResualeEmailTextfeild(
                    onchange: model.onemailchanged, 
                    emailcontroller: model.emailcontroller, 
                    errortext: model.emailerror
                    ),
                   SizedBox(height: 10,),
                   appbutton(title: "Continue", onTap: model.oncontinue),
                   SizedBox(height: 17,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "I have an account?",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      SizedBox(width: 5,),
                      GestureDetector(
                        onTap: model.ongotologin,
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "button",
                            fontWeight: FontWeight.w600
                          ),
                        ),
              
                      )
                    ],
                   )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
