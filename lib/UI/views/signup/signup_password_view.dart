import 'package:englify_app/UI/views/signup/signup_password_view_model.dart';
import 'package:englify_app/UI/widgets/reusable_condition_tile.dart';
import 'package:englify_app/UI/widgets/reusable_elevated_blue_button.dart';
import 'package:englify_app/UI/widgets/reusable_pass_txtfeild.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignupPasswordView extends StatelessWidget {
  const SignupPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<SignupPasswordViewModel>.reactive(
      viewModelBuilder: () => SignupPasswordViewModel(),
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
                    SizedBox(height: 20),
                    Row(children: [
                      IconButton(onPressed: model.onback, icon: Icon(Icons.arrow_back_sharp, color: Colors.white),),
                         SizedBox(width: size.width*0.09,),
                         Center(child: Text("Sign up with Email",
                      style: TextStyle(
                      
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),),),
                      ],
                    ),
                    SizedBox(height: size.height*0.10,),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontFamily: "buton",
                        fontSize: 14,
                        color: Colors.white
                      ),
                    ),
                    SizedBox(height: 5,),
                    ReusablePassTxtfeild(
                      isobscue: model.isobscure, 
                      onchnage: model.onchangepass, 
                      passcontroller: model.passwordcontroller, 
                      toggle: model.togglevisibality
                      ),
                      SizedBox(height: 12,),
                      ReusableConditionTile(isvalid: model.hasminilenght, txt:"At least 8 cherecters"),
                      ReusableConditionTile(isvalid: model.hasuppercase, txt: "At least 1 uppercase letter"),
                      ReusableConditionTile(isvalid: model.haslowercase, txt: "At least 1 lowercase letter"),
                      ReusableConditionTile(isvalid: model.hasnumber, txt: "At least 1 number"),
                      SizedBox(height: 25,),
                      appbutton(title: "Create account", onTap: model.oncreate),
                      SizedBox(height: 17,),
                  Column(
  children: [
    Wrap(
      alignment: WrapAlignment.start,
      children: [
        Text(
          'By creating an account, you agree to the ',
          style: TextStyle(
            fontFamily: "button",
            fontSize: 12,
            color: Colors.white60,
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Terms of Service',
            style: TextStyle(
              fontFamily: "button",
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
    Wrap(
      alignment: WrapAlignment.start,
      children: [
        Text(
          'and ',
          style: TextStyle(
            fontFamily: "button",
            fontSize: 12,
            color: Colors.white60,
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Privacy Policy',
            style: TextStyle(
              fontFamily: "button",
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
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
