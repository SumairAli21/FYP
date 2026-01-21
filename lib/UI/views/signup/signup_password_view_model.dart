import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignupPasswordViewModel extends BaseViewModel {
  final passwordcontroller = TextEditingController();
  final _navigationservice = locator<NavigationService>();
  bool isobscure = true;

  bool get hasminilenght => passwordcontroller.text.length >= 8;
  bool get hasuppercase => passwordcontroller.text.contains(RegExp(r'[A-Z]'));
  bool get haslowercase => passwordcontroller.text.contains(RegExp(r'[a-z]'));
  bool get hasnumber => passwordcontroller.text.contains(RegExp(r'[0-9]'));

  bool get ispassvalid =>
      hasminilenght && hasuppercase && haslowercase && hasnumber;

  void togglevisibality() {
    isobscure = !isobscure;
    notifyListeners();
  }

  void onchangepass(String value) {
    notifyListeners();
  }

  void oncreate() {
    if (!ispassvalid) return;
    _navigationservice.navigateToLoginView();
  }

  void onback() {
    _navigationservice.back();
  }
}
