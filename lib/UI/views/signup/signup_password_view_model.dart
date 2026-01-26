import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:englify_app/services/user_service.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignupPasswordViewModel extends BaseViewModel {
  String email;
  SignupPasswordViewModel({required this.email});
  final passwordcontroller = TextEditingController();
  final _navigationservice = locator<NavigationService>();
  final _localstorageservice = locator<LocalStorageService>();
  final _authservice = locator<AuthService>();
  final _userservice = locator<UserService>();

  bool isobscure = true;
  String? role;

  Future<void> init() async {
    role = await _localstorageservice.getuserrole();
    print("ROLE FROM LOCAL STORAGE: $role");
  }

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

  void oncreate() async {
    if (!ispassvalid || role == null) return;

    setBusy(true);
    try {
      final user = await _authservice.signup(
        email,
        passwordcontroller.text.trim(),
      );

      if (user != null) {
        await _userservice.createuser(email: email, uid: user.uid, role: role!);

        _navigationservice.navigateToLoginView();
      }
    } catch (e) {
      print(e);
    }

    setBusy(false);
    notifyListeners();
  }

  void onback() {
    _navigationservice.back();
  }
}
