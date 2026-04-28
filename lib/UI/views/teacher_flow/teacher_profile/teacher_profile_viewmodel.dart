import 'dart:io';

import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:englify_app/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TeacherProfileViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _localStorage = locator<LocalStorageService>();
  final _profileService = locator<ProfileService>();

  String username = '';
  String location = '';
  String? profileImageUrl;
  bool isGoogleAccount = false;
  bool isUploadingImage = false;
  bool isSoundEnabled = true;
  bool isNotificationEnabled = true;

  Future<void> init() async {
    setBusy(true);
    try {
      // Local storage se username load karo
      final name = await _localStorage.getusername();
      username = name ?? 'Teacher';

      // Firestore se profile load karo
      final profile = await _profileService.getProfile();
      if (profile != null) {
        profileImageUrl = profile['profileImageUrl'] as String?;
        location = profile['location'] as String? ?? '';
      }

      isGoogleAccount = await _profileService.isGoogleAccount();
    } catch (e) {
      print('Failed to init teacher profile: $e');
    }
    setBusy(false);
  }

  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (picked == null) return;

    isUploadingImage = true;
    notifyListeners();

    final url = await _profileService.uploadProfileImage(File(picked.path));
    if (url != null) {
      profileImageUrl = url;
      await _profileService.saveProfile(imageUrl: url);
    }

    isUploadingImage = false;
    notifyListeners();
  }

  // Username update — local storage + Firestore dono mein
  Future<void> updateUsername(String newUsername) async {
    if (newUsername.isEmpty) return;
    username = newUsername;
    notifyListeners();
    await _localStorage.saveusername(newUsername);
  }

  Future<void> updateLocation(String newLocation) async {
    location = newLocation;
    notifyListeners();
    await _profileService.saveProfile(location: newLocation);
  }

  void toggleSound() {
    isSoundEnabled = !isSoundEnabled;
    notifyListeners();
  }

  void toggleNotification() {
    isNotificationEnabled = !isNotificationEnabled;
    notifyListeners();
  }

  void onRules() {
    _navigationService.navigateToRulesView();
  }

  void onFeedback() {
    _navigationService.navigateToFeedbackView();
  }

  void onSettings() {}
  void onTerms() => _navigationService.navigateToTermsandcondView();
  void onPrivacy() => _navigationService.navigateToPrivecyandpolicyView();

  void onChangePassword() {
    if (isGoogleAccount) return;
    _navigationService.navigateToChangePasswordView();
  }

  Future<void> logout(BuildContext context) async {
    setBusy(true);
    try {
      await _authService.signOut();
      await _localStorage.isloginfalse();
      await _localStorage.clearusername();
      await _localStorage.clearuserrole();
      _navigationService.clearStackAndShow(Routes.roleSelection);
    } catch (e) {
      print('Failed to logout: $e');
    }
    setBusy(false);
  }
}
