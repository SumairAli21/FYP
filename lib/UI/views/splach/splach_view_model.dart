import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:englify_app/services/online_DB_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplachViewModel extends BaseViewModel {
  final _localstorage = locator<LocalStorageService>();
  final _navigationservice = locator<NavigationService>();
  final _authservice = locator<AuthService>();
  final _classroomservice = locator<classroomservice>();

  Future<void> runsetuplogic() async {
    await Future.delayed(Duration(seconds: 3));

    final isfirstlaunch = await _localstorage.isfirstlaunch();

    if (isfirstlaunch) {
      _navigationservice.replaceWithOnbordingView();
      return;
    }

    final role = await _localstorage.getuserrole();
    if (role == null) {
      _navigationservice.replaceWithRoleSelection();
      return;
    }

    final login = await _localstorage.getislogin();
    if (!login) {
      _navigationservice.replaceWithAuthView();
      return;
    }

    // Teacher flow
    if (role == "teacher") {
      _navigationservice.replaceWithTeacherBottomTabView();
      return;
    }

    // ✅ STUDENT FLOW - Check from DATABASE, not local storage
    final user = _authservice.currentuser;
    if (user != null) {
      try {
        // Check if student has joined any classroom from DATABASE
        final classes = await _classroomservice
            .getstudentclasses(user.uid)
            .first;

        if (classes.docs.isNotEmpty) {
          // ✅ User has joined classroom - sync local storage and go to home
          await _localstorage.setclassroomjointrue();
          _navigationservice.replaceWithBottomNaviView();
          return;
        } else {
          // ✅ User has NOT joined any classroom - clear local storage if exists
          await _localstorage.clearclassroomjoin();
          _navigationservice.replaceWithPersonalizationView();
          return;
        }
      } catch (e) {
        // Error checking database - fallback to personalization
        print("Error checking classroom: $e");
        _navigationservice.replaceWithPersonalizationView();
        return;
      }
    }

    // Fallback
    _navigationservice.replaceWithPersonalizationView();
  }
}