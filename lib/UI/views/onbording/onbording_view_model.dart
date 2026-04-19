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

  // ✅ Update current index and notify listeners
  void updateCurrentIndex(int index) {
    currentindex = index;
    notifyListeners();
  }

  // ✅ Go to next page
  void nextpage() {
    if (currentindex < 2) {
      currentindex++;
      pageController.animateToPage(
        currentindex,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    } else {
      // Last page - navigate to role selection
      oncontinue();
    }
  }

  // ✅ Complete onboarding and navigate
  Future<void> oncontinue() async {
    await splachstorage.setfirstlaunchfalse();
    _navigationservice.replaceWithRoleSelection();
  }

  // ✅ Skip onboarding
  Future<void> onskip() async {
    await splachstorage.setfirstlaunchfalse();
    _navigationservice.replaceWithRoleSelection();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}