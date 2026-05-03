import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/dashboard_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TeacherDashboadViewmodel  extends BaseViewModel{
  final _navigationService = locator<NavigationService>();
  final _dashboardService = locator<DashboardService>();
  final _authService = locator<AuthService>();
 
  // ── Stats
  int totalClassrooms = 0;
  int totalStudents = 0;
  double avgAttendance = 0.0;
  double avgScore = 0.0;
 
  // ── Top class
  TopClassInfo? topClass;
 
  String get teacherId => _authService.currentuser?.uid ?? '';
 
  Future<void> init() async {
    setBusy(true);
    try {
      final results = await Future.wait([
        _dashboardService.getTotalClassrooms(teacherId),
        _dashboardService.getTotalStudents(teacherId),
        _dashboardService.getAverageAttendance(teacherId),
        _dashboardService.getAverageScore(teacherId),
        _dashboardService.getTopPerformingClass(teacherId),
      ]);
 
      totalClassrooms = results[0] as int;
      totalStudents = results[1] as int;
      avgAttendance = results[2] as double;
      avgScore = results[3] as double;
      topClass = results[4] as TopClassInfo?;
    } catch (e) {
      print('Dashboard init error: $e');
    }
    setBusy(false);
  }
 
  // ── Navigate to teacher's classrooms list
  void onClassroomsTap() {
    _navigationService.navigateTo(Routes.classroomdetailView);
  }
 
  // ── Navigate to students listing
  void onStudentsTap() {
    _navigationService.navigateTo(
      Routes.studentsListView,
      arguments: StudentsListViewArguments(teacherId: teacherId),
    );
  }
 
  // ── Navigate to class detail from top performing card
 void onViewClassDetails() {
  if (topClass == null) return;

  _navigationService.navigateTo(
    Routes.classroomdetailView,
    arguments: ClassroomdetailViewArguments(
      classroom: {
        'id': topClass!.classId,
        'name': topClass!.className,
        'averageScore': topClass!.averageScore,
      },
    ),
  );
}
}