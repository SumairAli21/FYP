import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:englify_app/services/online_DB_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PersonalizationViewModel extends BaseViewModel {
  final _navigationservice = locator<NavigationService>();
  final _localstorageservice = locator<LocalStorageService>();
  final _authservice = locator<AuthService>();
  final _classroomservice = locator<classroomservice>();
  final usernamecontroller = TextEditingController();
  
  String? errormessage;

  // ✅ REMOVED init() - No automatic check on load

  Future<void> oncontinue() async {
    // Clear previous error
    errormessage = null;
    notifyListeners();
    
    final username = usernamecontroller.text.trim();
    
    // ✅ STEP 1: Validate name FIRST
    if (username.isEmpty) {
      errormessage = "Please enter your name";
      notifyListeners();
      return;
    }
    
    if (username.length < 2) {
      errormessage = "Name must be at least 2 characters";
      notifyListeners();
      return;
    }
    
    setBusy(true);
    
    try {
      // ✅ STEP 2: Save username to local storage
      await _localstorageservice.saveusername(username);
      print("✅ Username saved: $username");
      
      // Verify save
      final savedName = await _localstorageservice.getusername();
      print("✅ Verification - Retrieved username: $savedName");
      
      if (savedName != username) {
        throw Exception("Username save verification failed");
      }
      
      // ✅ STEP 3: NOW check if user already joined a classroom (AFTER name is saved)
      final user = _authservice.currentuser;
      if (user != null) {
        try {
          final hasClasses = await _classroomservice.hasStudentJoinedAnyClass(user.uid);

          if (hasClasses) {
            // ✅ User already joined - sync local storage and go to home
            print("✅ User has joined classes - navigating to home");
            await _localstorageservice.setclassroomjointrue();
            setBusy(false);
            _navigationservice.replaceWithBottomNaviView();
            return;
          } else {
            // ✅ User has NOT joined - go to classroom code
            print("✅ User has 0 classes - navigating to classroom code");
            setBusy(false);
            _navigationservice.replaceWithClassroomcodeView();
            return;
          }
        } catch (e) {
          print("❌ Error checking classroom: $e");
          // On error, default to classroom code screen
          setBusy(false);
          _navigationservice.replaceWithClassroomcodeView();
          return;
        }
      }
      
      // ✅ Fallback - if no user, still go to classroom code
      setBusy(false);
      _navigationservice.replaceWithClassroomcodeView();
      
    } catch (e) {
      setBusy(false);
      errormessage = "Failed to save. Please try again.";
      notifyListeners();
      print("❌ Error in oncontinue: $e");
    }
  }

  @override
  void dispose() {
    usernamecontroller.dispose();
    super.dispose();
  }
}