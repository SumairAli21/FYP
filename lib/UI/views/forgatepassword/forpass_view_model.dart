import 'package:englify_app/app/app.locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ForgotPasswordViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _auth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  String? errorMessage;
  bool emailSent = false;

  bool get canSubmit => emailController.text.trim().isNotEmpty;

  void onEmailChanged() {
    errorMessage = null;
    notifyListeners();
  }

  Future<void> onContinue() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      errorMessage = 'Please enter your email address.';
      notifyListeners();
      return;
    }

    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email)) {
      errorMessage = 'Invalid email address.';
      notifyListeners();
      return;
    }

    setBusy(true);
    errorMessage = null;

    try {
      await _auth.sendPasswordResetEmail(email: email);
      emailSent = true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No account found with this email.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        default:
          errorMessage = 'Something went wrong. Please try again.';
      }
    } catch (e) {
      errorMessage = 'Something went wrong. Please try again.';
    }

    setBusy(false);
    notifyListeners();
  }

  void onBack() => _navigationService.back();

  void onSignIn() => _navigationService.back();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}