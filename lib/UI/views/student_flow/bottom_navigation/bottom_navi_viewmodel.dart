import 'package:englify_app/UI/views/privecy&policy/privecyandpolicy_view.dart';
import 'package:englify_app/UI/views/student_flow/studenhome/student_home_view.dart';
import 'package:englify_app/UI/views/student_flow/student_dashboard/student_dashboard_view.dart';
import 'package:englify_app/UI/views/student_flow/student_fav/student_fav_view.dart';
import 'package:englify_app/UI/views/student_flow/student_profile/student_profile_view.dart';
import 'package:englify_app/UI/views/terms&condition/terms&cond_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BottomNaviViewmodel extends BaseViewModel {
  int _currrentindex = 0;

   List<Widget> get pages => [StudentHomeView(),StudentDashboardView(),StudentFavView(),StudentProfileView()];

  int get currentindex => _currrentindex;
  onindexchange(int index) {
    _currrentindex = index;
    notifyListeners();
  }
}
