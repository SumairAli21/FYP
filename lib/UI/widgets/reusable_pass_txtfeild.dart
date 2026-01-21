import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReusablePassTxtfeild extends StatelessWidget {
  VoidCallback toggle;
  bool isobscue;
  ValueChanged<String> onchnage;
  TextEditingController passcontroller = TextEditingController();
  ReusablePassTxtfeild({super.key,required this.isobscue,required this.onchnage,required this.passcontroller,required this.toggle});

  @override
  Widget build(BuildContext context) {
    return TextField(
       cursorColor: Colors.white,
      controller: passcontroller,
      onChanged: onchnage,
      obscureText: isobscue,
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        suffixIcon: IconButton(
        onPressed: toggle, 
        icon: isobscue? Icon(Icons.visibility_off, color: Colors.white70) : Icon(Icons.visibility, color: Colors.white70),
        ),
        hintText: "Enter your password",
        hintStyle: TextStyle(color: Colors.white38),
        filled: true,
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
       
      ),
    );
  }
}
