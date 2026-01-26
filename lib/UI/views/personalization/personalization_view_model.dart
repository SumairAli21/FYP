import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PersonalizationViewModel extends BaseViewModel {
  final _navigationservice = locator<NavigationService>();
  final _localstorageservice = locator<LocalStorageService>();
  final usernamecontroller = TextEditingController();
  String? errormasage;

  Future<void> oncontinue() async {
    final username = usernamecontroller.text.trim();
    if (username.isEmpty) {
      errormasage = "Enter a name";
      notifyListeners();
      return;
    }
    await _localstorageservice.saveusername(username);
    _navigationservice.replaceWithClassroomcodeView();
  }

  void dispose() {
    usernamecontroller.dispose();
    super.dispose();
  }
}
