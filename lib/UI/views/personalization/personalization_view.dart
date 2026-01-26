import 'package:englify_app/UI/views/personalization/personalization_view_model.dart';
import 'package:englify_app/UI/widgets/reusable_elevated_blue_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PersonalizationView extends StatelessWidget {
  const PersonalizationView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<PersonalizationViewModel>.reactive(
      viewModelBuilder: () => PersonalizationViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Image.asset("assets/images/applogo_blue.png",
                  height: 150,
                  width: 200,
                  ),
                
                 Text(
                    "What’s your name?",
                    style: TextStyle(
                      fontFamily: "heading",
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    "Enter your name so we know what to call you. "
                    "We’ll use it to personalize your app and orders.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height:15,),
                  Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 4),
                  TextField(
       cursorColor: Colors.black,
      controller: model.usernamecontroller,
      style: TextStyle(color: Colors.black),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "Enter your name",
        hintStyle: TextStyle(color: Colors.black38),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF2F6BFF), width: 1.6),
        ),
       
      ),
    ),
    SizedBox(height: 20,),
    appbutton(title: 'Continue', onTap: model.oncontinue)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
