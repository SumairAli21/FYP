import 'dart:ffi';

import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/models/lesson_data_model.dart';
import 'package:englify_app/services/create_lesson_service.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StudentClassroomDetailViewmodel extends BaseViewModel {
  final _navigationservice = locator<NavigationService>();
  final _lessonservice = locator<CreateLessonService>();
  final Map<String, dynamic> classroom;

  StudentClassroomDetailViewmodel(this.classroom);

  String get classId => classroom['id'] ?? '';
  String get className => classroom['name'] ?? '';
  String get classCode => classroom['code'] ?? '';

  final serachcontroller = TextEditingController();

  List<LessonData> _allessons = [];
  List<LessonData> lessons = [];

  Future<void> loadlesson() async {
    setBusy(true);
    try {
      _allessons = await _lessonservice.getlesssonsdata(classId);
      lessons = List.from(_allessons);
    } catch (e) {
      throw extension("no lesson");
    }
    setBusy(false);
  }

  void onsearchchanged(String value) {
    if (value.trim().isEmpty) {
      lessons = List.from(_allessons);
    } else {
      lessons = _allessons
          .where((l) => l.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void clearseach() {
    serachcontroller.clear();
    lessons = List.from(_allessons);
    notifyListeners();
  }

  void gotolessondetail(LessonData lesson) {
    _navigationservice.navigateToStdSelectLessonView(
      lesson: lesson,
      classroom: classroom,
    );
  }

  void onback() => _navigationservice.back();

  @override
  void dispose() {
    serachcontroller.dispose();
    super.dispose();
  }
}
