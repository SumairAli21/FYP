import 'package:englify_app/app/app.locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChnagepasswordViewmodel extends BaseViewModel{
  final _navigationService = locator<NavigationService>();
  final _auth = FirebaseAuth.instance;

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool showOldPassword = false;
  bool showNewPassword = false;
  bool showConfirmPassword = false;

  String? errorMessage;
  bool isSuccess = false;

  void toggleOldPassword() {
    showOldPassword = !showOldPassword;
    notifyListeners();
  }

  void toggleNewPassword() {
    showNewPassword = !showNewPassword;
    notifyListeners();
  }

  void toggleConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    notifyListeners();
  }

  Future<void> changePassword(BuildContext context) async {
    final oldPass = oldPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    // Validation
    if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      errorMessage = 'Please fill all fields';
      notifyListeners();
      return;
    }

    if (newPass.length < 6) {
      errorMessage = 'New password must be at least 6 characters';
      notifyListeners();
      return;
    }

    if (newPass != confirmPass) {
      errorMessage = 'New password and confirm password do not match';
      notifyListeners();
      return;
    }

    if (oldPass == newPass) {
      errorMessage = 'New password cannot be same as old password';
      notifyListeners();
      return;
    }

    setBusy(true);
    errorMessage = null;
    notifyListeners();

    try {
      final user = _auth.currentUser;
      if (user == null || user.email == null) {
        errorMessage = 'User not found';
        setBusy(false);
        notifyListeners();
        return;
      }

      // Re-authenticate with old password
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPass,
      );

      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newPass);

      setBusy(false);
      isSuccess = true;
      notifyListeners();

      // Success dialog
      if (context.mounted) {
        _showSuccessDialog(context);
      }
    } on FirebaseAuthException catch (e) {
      setBusy(false);
      switch (e.code) {
        case 'wrong-password':
        case 'invalid-credential':
          errorMessage = 'Old password is incorrect';
          break;
        case 'weak-password':
          errorMessage = 'New password is too weak';
          break;
        case 'requires-recent-login':
          errorMessage = 'Please login again and retry';
          break;
        default:
          errorMessage = 'Something went wrong. Try again';
      }
      notifyListeners();
    } catch (e) {
      setBusy(false);
      errorMessage = 'Something went wrong. Try again';
      notifyListeners();
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          '✅ Password Changed!',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'Your password has been updated successfully.',
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F6BFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              _navigationService.back();
            },
            child: const Text('OK',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void onBack() => _navigationService.back();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}