import 'package:englify_app/UI/views/teacher_flow/teacher_dashboard/teacher_dashboard_view.dart';
import 'package:englify_app/UI/views/teacher_flow/teacher_home/teacher_home_view.dart';
import 'package:englify_app/UI/views/teacher_flow/teacher_profile/teacher_profile_view.dart';
import 'package:englify_app/UI/views/teacher_flow/teacher_tracker/teacher_tracker_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TeacherBottomTabViewmodel extends BaseViewModel {
  int _currrentindex = 0;

  List<Widget> get pages => const [
        TeacherHomeView(),
        TeacherDashboardView(),
        TeacherTrackerView(),
        TeacherProfileView(),
      ];

  int get currentindex => _currrentindex;
  
  void onindexchange(int index) {
    _currrentindex = index;
    notifyListeners();
  }
}