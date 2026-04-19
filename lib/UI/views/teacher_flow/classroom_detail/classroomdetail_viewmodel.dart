import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/models/lesson_data_model.dart';
import 'package:englify_app/services/create_lesson_service.dart';
import 'package:englify_app/services/firestore_keys.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ClassroomdetailViewmodel extends BaseViewModel {
  final _navigationservice = locator<NavigationService>();
  final _lessonservice = locator<CreateLessonService>();
  final Map<String, dynamic> classroom;

  ClassroomdetailViewmodel(this.classroom);

  String get classId => classroom['id'] ?? '';
  String get className => classroom[FirestoreKeys.className] ?? '';
  String get classCode => classroom[FirestoreKeys.classCode] ?? '';
  String get description => classroom[FirestoreKeys.classDescription] ?? '';
  int get currentStudents => classroom[FirestoreKeys.currentStudentCount] ?? 0;
  int get maxStudents => classroom[FirestoreKeys.maxStudents] ?? 0;
  String? get imageUrl => classroom[FirestoreKeys.imageUrl];

  final searchcontroller = TextEditingController();

  List<LessonData> _alllessons = [];
  List<LessonData> lessons = [];

  Future<void> loadlessons() async {
    setBusy(true);
    try {
      _alllessons = await _lessonservice.getlesssonsdata(classId);
      lessons = List.from(_alllessons);
    } catch (e) {
      print("failed to load lessons");
    }
    setBusy(false);
  }

  void onsearchchnage(String value) {
    if (value.trim().isEmpty) {
      lessons = List.from(_alllessons);
    } else {
      lessons = _alllessons
          .where((l) => l.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void onclearsearch() {
    searchcontroller.clear();
    lessons = List.from(_alllessons);
    notifyListeners();
  }

  void onlessontap(LessonData lesson) {
    _navigationservice.navigateToLessonDetailView(
      classroom: classroom,
      lessons: lesson,
    );
  }

  void onback() {
    _navigationservice.back();
  }

  void gotocreatelesson() {
    _navigationservice.navigateToCreateLessonView(classid: classId);
  }
}
