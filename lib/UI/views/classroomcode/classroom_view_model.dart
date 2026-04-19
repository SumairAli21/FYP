import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:englify_app/services/online_DB_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ClassroomViewModel extends BaseViewModel {
  final _navigationservice = locator<NavigationService>();
  final _classroomcodeservice = locator<classroomservice>();
  final _authservice = locator<AuthService>();
  final _localstorageservice = locator<LocalStorageService>();
  final classcodecontroller = TextEditingController();

  String? errormessage;
  
  Future<void> joinclass() async {
    // Clear previous error
    errormessage = null;
    notifyListeners();
    
    final classcode = classcodecontroller.text.trim();
    
    if (classcode.isEmpty) {
      errormessage = "Please enter class code";
      notifyListeners();
      return;
    }
    
    setBusy(true);
    
    final user = _authservice.currentuser;
    if (user == null) {
      errormessage = "User not logged in";
      setBusy(false);
      notifyListeners();
      return;
    }

    final result = await _classroomcodeservice.joinclass(
      classcode: classcode,
      studentid: user.uid,
    );
    
    setBusy(false);
    
    // Check if there's an error
    if (result != null) {
      // Error occurred - show error and STOP here
      errormessage = result;
      notifyListeners();
      return;
    }
    
    // ✅ Success - sync local storage and navigate
    await _localstorageservice.setclassroomjointrue();
    _navigationservice.replaceWithBottomNaviView();
  }

  void onback() {
    _navigationservice.back();
  }

  @override
  void dispose() {
    classcodecontroller.dispose();
    super.dispose();
  }
}