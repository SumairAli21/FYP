import 'package:englify_app/UI/views/signup/signup_email_view_model.dart';
import 'package:englify_app/UI/widgets/resuale_email_textfeild.dart';
import 'package:englify_app/UI/widgets/reusable_elevated_blue_button.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Signupemailview extends StatelessWidget {
  const Signupemailview({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupEmailViewModel>.reactive(
      viewModelBuilder: () => SignupEmailViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.rs(24)),
                child: ResponsiveContainer(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  SizedBox(height: context.rs(20),),
                  Row(
                      children: [
                         IconButton(onPressed: model.onback, icon: Icon(Icons.arrow_back_sharp, color: Colors.white),),
                         Expanded(child: Text("Sign up with Email",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(

                        fontSize: context.rf(22),
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),),),
                         SizedBox(width: context.rs(48),),
                      ],
                  ),
                    SizedBox(height: context.heightPercent(10),),
                    Text(
                      "Email address",
                      style: TextStyle(
                        fontFamily: "button",
                        fontSize: context.rf(14),
                        color: Colors.white,
                      ),

                    ),
                    SizedBox(height: context.rs(5),),
                    ResualeEmailTextfeild(
                    onchange: model.onemailchanged,
                    emailcontroller: model.emailcontroller,
                    errortext: model.emailerror
                    ),
                   SizedBox(height: context.rs(10),),
                   AppButton(title: "Continue" ,onTap: model.oncontinue, ),
                   SizedBox(height: context.rs(17),),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          "I have an account?",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                      SizedBox(width: context.rs(5),),
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
          ),
        );
      },
    );
  }
}
