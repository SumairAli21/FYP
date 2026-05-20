import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/tracker_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TeacherTrackerViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _trackerService = locator<TrackerService>();
  final _authService = locator<AuthService>();

  List<StudentTrackerSummary> students = [];

  Future<void> init() async {
    setBusy(true);
    try {
      final teacherId = _authService.currentuser?.uid;
      if (teacherId != null && teacherId.isNotEmpty) {
        students = await _trackerService.getStudentsWhoAttempted(teacherId);
      }
    } catch (e) {
      print('❌ Tracker load error: $e');
    }
    setBusy(false);
  }

  Future<void> refresh() => init();

  void onStudentTap(StudentTrackerSummary student) {
    _navigationService.navigateToStudentQuizRecordView(summary: student);
  }
}
