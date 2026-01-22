import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignupEmailViewModel extends BaseViewModel {
  final _navigationservice = locator<NavigationService>();
  

  final emailcontroller = TextEditingController();
  String? emailerror;



  bool get isemailvalid {
    final email = emailcontroller.text.trim();
    return email.isNotEmpty && email.contains("@");
  }

  void onemailchanged(String value) {
    if (value.isEmpty) {
      emailerror = "Email is required";
    } else if (!value.contains("@")) {
      emailerror = "Enter a valid email";
    } else {
      emailerror = null;
    }
  }

  void oncontinue() {
    if (!isemailvalid) {
      emailcontroller.clear();
      emailerror = "Enter a valid email";
      notifyListeners();
      return;
    }
    _navigationservice.navigateToSignupPasswordView(
      email: emailcontroller.text.trim()
    );
  }

  void ongotologin() {
    _navigationservice.navigateToLoginView();
  }

  void onback() {
    _navigationservice.back();
  }

  void ongotosignup() {
    _navigationservice.back();
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }
}
