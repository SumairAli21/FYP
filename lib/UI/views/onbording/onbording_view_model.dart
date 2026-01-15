import 'dart:ffi';

import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OnbordingViewModel extends BaseViewModel {
  final _navigationservice = locator<NavigationService>();
  final splachstorage = locator<LocalStorageService>();

  final PageController pageController = PageController();
  int currentindex = 0;

  void nextpage() {
    if (currentindex < 2) {
      currentindex++;
      pageController.animateToPage(
        currentindex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> oncontinue() async {
    await splachstorage.setfirstlaunchfalse();
    _navigationservice.replaceWithRoleSelection();
  }

  Future<void> onskip() async {
    await splachstorage.setfirstlaunchfalse();
    _navigationservice.replaceWithRoleSelection();
  }
void dispose(){
  pageController.dispose();
  super.dispose();
}
}
