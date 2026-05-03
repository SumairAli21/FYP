import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/dashboard_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StudentsListViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dashboardService = locator<DashboardService>();
 
  final String teacherId;
  StudentsListViewmodel({required this.teacherId});
 
  List<StudentSummary> students = [];
 
  Future<void> init() async {
    setBusy(true);
    try {
      students = await _dashboardService.getAllStudents(teacherId);
    } catch (e) {
      print('Students list error: $e');
    }
    setBusy(false);
  }
 
  void onStudentTap(String studentId) {
    _navigationService.navigateTo(
      Routes.studentDetailView,
      arguments: StudentDetailViewArguments(
        teacherId: teacherId,
        studentId: studentId,
      ),
    );
  }
 
  void onBack() => _navigationService.back();
}
 