import 'dart:io';
import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:englify_app/services/pints_service.dart';
import 'package:englify_app/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _localStorage = locator<LocalStorageService>();
  final _profileService = locator<ProfileService>();
  final _pointsService = locator<PointsService>();

  // ── User data
  String username = '';
  String location = '';
  String? profileImageUrl;
  int totalCoins = 0;
  int totalQuizAttempts = 0;
  bool isGoogleAccount = false;

  // ── Toggle states
  bool isSoundEnabled = true;
  bool isNotificationEnabled = true;

  // ── Upload state
  bool isUploadingImage = false;

  // ── Level system
  int get level => _calculateLevel(totalQuizAttempts);

  int _calculateLevel(int attempts) {
    if (attempts < 2) return 1;
    if (attempts < 6) return 2;
    if (attempts < 14) return 3;
    if (attempts < 30) return 4;
    return 5;
  }

  String get levelText => 'Lvl $level';
  String get pointsText => '$totalCoins Points';

  Future<void> init() async {
    setBusy(true);
    try {
      // Load username from shared prefs
      final name = await _localStorage.getusername();
      username = name ?? 'User';

      // Load profile from Firestore
      final profile = await _profileService.getProfile();
      if (profile != null) {
        profileImageUrl = profile['profileImageUrl'] as String?;
        location = profile['location'] as String? ?? '';
        totalCoins = (profile['totalCoins'] ?? 0) as int;
      }

      // Load quiz attempts
      totalQuizAttempts = await _profileService.getTotalQuizAttempts();

      // Check if Google account
      isGoogleAccount = await _profileService.isGoogleAccount();
    } catch (e) {
      print('Failed to init profile: $e');
    }
    setBusy(false);
  }

  // ── Pick and upload profile image
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

  // ── Toggle sound
  void toggleSound() {
    isSoundEnabled = !isSoundEnabled;
    notifyListeners();
  }

  // ── Toggle notification
  void toggleNotification() {
    isNotificationEnabled = !isNotificationEnabled;
    notifyListeners();
  }

  // ── Navigation
  void onRules() {} // abi khaali

  void onFeedback() {
    _navigationService.navigateToFeedbackView();
  } 

  void onTerms() {
    _navigationService.navigateToTermsandcondView();
  }

  void onPrivacy() {
    _navigationService.navigateToPrivecyandpolicyView();
  }

  void onChangePassword() {
    if (isGoogleAccount) return; // Google account — disabled
    _navigationService.navigateToChangePasswordView();
  }

  // ── Logout
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

  Future<void> updateLocation(String newLocation) async {
    location = newLocation;
    notifyListeners();
    await _profileService.saveProfile(location: newLocation);
  }

  void onSettings() {} // abi khaali
}
