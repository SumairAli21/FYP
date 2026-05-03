import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/dashboard_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StudentDetailViewModel extends BaseViewModel {
  final _dashboardService = locator<DashboardService>();
  final _navigationService = locator<NavigationService>();

  final String teacherId;
  final String studentId;

  StudentDetailViewModel({required this.teacherId, required this.studentId});

  StudentDetail? student;

  Future<void> init() async {
    // FIX: was using isBusyLoading (custom flag) but view checks model.isBusy
    // Stacked's setBusy() is the correct way — triggers isBusy on the view
    setBusy(true);

    try {
      student = await _dashboardService.getStudentDetail(
        teacherId: teacherId,
        studentId: studentId,
      );
    } catch (e) {
      print("Student detail error: $e");
    }

    setBusy(false);
  }

  void backToDashboard() {
    _navigationService.clearStackAndShow(Routes.teacherBottomTabView);
  }
}
