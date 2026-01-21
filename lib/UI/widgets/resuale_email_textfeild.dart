import 'package:flutter/material.dart';

class ResualeEmailTextfeild extends StatelessWidget {
  ValueChanged<String> onchange;
  TextEditingController emailcontroller = TextEditingController();
  String? errortext;
  
  ResualeEmailTextfeild({
    super.key,
    required this.onchange,
    required this.emailcontroller,
    required this.errortext,
  
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      controller: emailcontroller,
      onChanged: onchange,
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email, color: Colors.white70),
        hintText: "Enter your email",
        hintStyle: TextStyle(color: Colors.white38),
        filled: true,
        errorText: errortext,
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.redAccent, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.redAccent, width: 1.6),
        ),
      ),
    );
  }
}
