import 'dart:ffi';

import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/models/classdata_model.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:englify_app/services/online_DB_service.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StudentHomeViewModel extends BaseViewModel {
  final _navigationservice = locator<NavigationService>();
  final _localstorage = locator<LocalStorageService>();
  final _classroomservice = locator<classroomservice>();
  final _authsercive = locator<AuthService>();

  final serachcontroller = TextEditingController();

  String username = '';
  List<ClassData> allclasses = [];
  List<ClassData> filteredclass = [];

  Future<void> init() async {
    setBusy(true);
    await _loadname();
    await _loadclasses();
    setBusy(false);
  }

  Future<void> _loadname() async {
    final name = await _localstorage.getusername();
    username = name ?? "Student";
    notifyListeners();
  }

  Future<void> _loadclasses() async {
    final user = await _authsercive.currentuser;
    if (user == null) return;

    try {
      final classes = await _classroomservice.getStudentClassesData(user.uid);
      allclasses = classes;
      filteredclass = classes;
      notifyListeners();
    } catch (e) {
      throw extension("no class");
    }
  }

  void onSearchChanged(String query) {
    if (query.isEmpty) {
      filteredclass = allclasses;
    } else {
      filteredclass = allclasses
          .where((cls) => cls.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  void joinclass() {
    _navigationservice.navigateToClassroomcodeView();
  }

  void gotoclassroomdetail(ClassData classdata) {
    _navigationservice.navigateToStudentClassroomDetaiView(
      classroom: classdata.toMap(),
    );
  }

  @override
  void dispose() {
    serachcontroller.dispose();
    super.dispose();
  }
}
