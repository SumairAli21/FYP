import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:englify_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationservice = locator<NavigationService>();
  final _localstorageservice = locator<LocalStorageService>();
  final _userservice = locator<UserService>();
  final _authservice = locator<AuthService>();

  String? errormasage;
  bool isobsurce = true;

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  void toggle() {
    isobsurce = !isobsurce;
    notifyListeners();
  }

  void onforgate() {
    _navigationservice.navigateToForpassView();
  }

  void onsignout() {
    _navigationservice.replaceWithSignupemailview();
  }

  Future<void> onlogin() async {
    setBusy(true);

    final email = emailcontroller.text.trim();
    final password = passwordcontroller.text.trim();

    final user = await _authservice.login(email, password);

    setBusy(false);

    if (user == null) {
      errormasage = "Invalid email or password";
      notifyListeners();
      return;
    }
    final role = await _userservice.getUserrole(user.uid);

    await _localstorageservice.islogintrue();

    if (role == "student") {
      _navigationservice.replaceWithPersonalizationView();
    } else if (role == "teacher") {
      _navigationservice.replaceWithTeacherHomeView();
    }
  }

  void onemailchage(String value) {
    notifyListeners();
  }

  void onpasschage(String value) {
    notifyListeners();
  }

  void onback() {
    _navigationservice.back();
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }
}
