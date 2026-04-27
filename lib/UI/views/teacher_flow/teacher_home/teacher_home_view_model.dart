import 'package:englify_app/UI/views/teacher_flow/classroom_detail/classroomdetail_view.dart';
import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/firestore_keys.dart';
import 'package:englify_app/services/classroom_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TeacherHomeViewModel extends BaseViewModel {
  final _navigationservice = locator<NavigationService>();
  final _classroomservice = locator<classroomservice>();
  final _authservice = locator<AuthService>();

  List<Map<String, dynamic>> _allClassrooms = []; // All classrooms
  List<Map<String, dynamic>> classrooms = []; // Filtered classrooms for display

  final searchcontroller = TextEditingController();
  void loadClassrooms() async {
    setBusy(true);

    final teacherId = _authservice.currentuser?.uid;
    if (teacherId == null) {
      setBusy(false);
      return;
    }

    _classroomservice.getTeacherClasses(teacherId).listen((snapshot) {
      _allClassrooms = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          'name': data[FirestoreKeys.className] ?? '',
          'code': data[FirestoreKeys.classCode] ?? '',
          'description': data[FirestoreKeys.classDescription] ?? '',
          'currentStudents': data[FirestoreKeys.currentStudentCount] ?? 0,
          'maxStudents': data[FirestoreKeys.maxStudents] ?? 0,
          'imageUrl': data[FirestoreKeys.imageUrl],
        };
      }).toList();

      // Initially show all classrooms
      classrooms = _allClassrooms;

      setBusy(false);
      notifyListeners();
    });
  }

  void onSearchChanged(String query) {
    if (query.isEmpty) {
      classrooms = _allClassrooms;
    } else {
      classrooms = _allClassrooms.where((classroom) {
        final name = classroom['name'].toString().toLowerCase();
        final code = classroom['code'].toString().toLowerCase();
        final searchLower = query.toLowerCase();

        // Search by name or code
        return name.contains(searchLower) || code.contains(searchLower);
      }).toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    searchcontroller.clear();
    classrooms = _allClassrooms;
    notifyListeners();
  }

  void oncreateclassroom() {
    _navigationservice.navigateToClassroomCreateView();
  }

  void onClassroomTap(Map<String, dynamic> classroom) {
    _navigationservice.navigateToClassroomdetailView(
      classroom:classroom
    );
  }

  @override
  void dispose() {
    searchcontroller.dispose();
    super.dispose();
  }
}
