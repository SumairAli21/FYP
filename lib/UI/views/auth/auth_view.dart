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
              Positioned.fill(
                child: Image.asset(
                  "assets/images/auth.png",
                  fit: BoxFit.cover,
                )
              ),

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end:  Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.15),
                        Colors.black.withOpacity(0.65)
                      ]
                    ),
                  ),
                )
                ),

                Positioned(
                  top: size.height * 0.0001,
                  left: 5,
                  child: Image.asset("assets/images/applogo.png",
                  height: 225,
                  )
                  
                ),

                Positioned(
                  left:23,
                  right: 23,
                  bottom: 70,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                      onPressed: (){},
                      icon: Icon(Icons.apple,size: 30, color: Colors.white, ),
                      label: Text(
                        "Coninue with Apple",
                        style: TextStyle(
                          fontFamily: "button",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2F6BFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                      ),
                    ),
                    SizedBox(height: 15),
                      SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                      onPressed: (){},
                      icon: FaIcon(FontAwesomeIcons.google,size: 28,color: Colors.black,),
                      label: Text(
                        "Coninue with Gmail",
                        style: TextStyle(
                          fontFamily: "button",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                      ),
                    ),
                    SizedBox(height: 15),
                      SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                      onPressed:model.continuewithemail,
                      icon: Icon(Icons.email,size: 30, color: Colors.black, ),
                      label: Text(
                        "Coninue with Email",
                        style: TextStyle(
                          fontFamily: "button",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                      ),
                    ),
                    SizedBox(height: 20),

                   Column(
                    children: [
                       Text("By continuing you agree to our",textAlign: TextAlign.center, style:  TextStyle(fontFamily: "button",fontSize: 12,color: Colors.white70),),
                    ],
                   ),
                   SizedBox(height: 6,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       TextButton(
                        onPressed: (){},
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(
                            decoration: TextDecoration.underline,
                            
                          ),
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          "privecy policy",
                           style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: "button",fontSize: 12,color: Colors.white),)),
                            SizedBox(width: 4,),
                        Text(
                          "and",
                          style: TextStyle(
                            color: Colors.white70),),
                            SizedBox(width: 4,),
                        TextButton(
                          onPressed: (){}, 
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
                          fontFamily: "button",fontSize: 12,color: Colors.white),))

                    ],
                   )
                  ],
                )
                ),

                
            ],
          ),

        );
      },
    );
  }
}
