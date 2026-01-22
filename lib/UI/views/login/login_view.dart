import 'package:englify_app/UI/views/login/login_view_model.dart';
import 'package:englify_app/UI/widgets/resuale_email_textfeild.dart';
import 'package:englify_app/UI/widgets/reusable_elevated_blue_button.dart';
import 'package:englify_app/UI/widgets/reusable_pass_txtfeild.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
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
                     Row(
                      children: [
                        IconButton(
                          onPressed: model.onback,
                          icon: Icon(
                            Icons.arrow_back_sharp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: size.width * 0.09),
                        Center(
                          child: Text(
                            "Sign up with Email",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
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
                    ResualeEmailTextfeild(onchange: model.onemailchage, emailcontroller: model.emailcontroller, errortext: model.errormasage),
                    SizedBox(height: 10,),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontFamily: "buton",
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    ReusablePassTxtfeild(isobscue: model.isobsurce, onchnage: model.onpasschage, passcontroller: model.passwordcontroller, toggle: model.toggle),
                  
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: model.onforgate, child: Text(
                        "Forget Password",
                        style: TextStyle(
                          fontFamily: "button",
                          fontSize: 12,
                          color: const Color.fromARGB(255, 249, 247, 247)
                        ),
                      )),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
      width: size.width,
      height: 52,
      child: ElevatedButton(
        onPressed: () async {
          model.onlogin();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2F6BFF),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          "Login",
          style: const TextStyle(
            fontFamily: "button",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    ),
                    SizedBox(height: 20,),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "I don't have an account? ",
                            style: TextStyle(
                              fontFamily: "button",
                              fontSize: 14,
                              color: Colors.white70
                            ),

                          ),
                          TextButton(onPressed: model.onsignout,style: TextButton.styleFrom(padding: EdgeInsets.zero,), child: Text(
                        "Sign out",
                        style: TextStyle(
                          fontFamily: "button",
                          fontSize: 14,
                          color: const Color.fromARGB(255, 249, 247, 247)
                        ),
                      )),
                        ],
                      ),
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
