import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/models/lesson_data_model.dart';
import 'package:englify_app/services/pints_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StdSelectLessonViewmodel extends BaseViewModel {
  final _navigationservice = locator<NavigationService>();
  final _pointsservice = locator<PointsService>();
  final LessonData lesson;
  final Map<String, dynamic> classrom;

  StdSelectLessonViewmodel({required this.lesson, required this.classrom});

  String get lessonname => lesson.title;
  String get lessonnumber =>
      "Lesson ${lesson.lessonNumber.toString().padLeft(2, "0")}";
  String get imageurl => lesson.imageUrl ?? '';

  int? quizscore;

  String get scoretext {
    if (quizscore == null) return '0/100';
    return '$quizscore/100';
  }

bool get isQuizAttempted => quizscore != null;

  Future<void> init() async {
    setBusy(true);
    quizscore = await _pointsservice.getquizpoints(lesson.id);
    setBusy(false);
  }

  // ✅ Lesson detail se wapas aane par points refresh
  Future<void> gotolessondetail() async {
    await _navigationservice.navigateToStdLessondetailView(
      lesson: lesson,
      classroom: classrom,
    );
    await _refreshpoints();
  }

  // ✅ Quiz attempt se wapas aane par points refresh
  Future<void> gotoattemptQuiz() async {
    if (isQuizAttempted) return;
    await _navigationservice.navigateToQuizAttemptView(
      classId: classrom['id'] ?? '',
      lessonId: lesson.id,
      lessonTitle: lesson.title,
    );
    await _refreshpoints();
  }

  Future<void> _refreshpoints() async {
    quizscore = await _pointsservice.getquizpoints(lesson.id);
    notifyListeners();
  }

  void onBack() => _navigationservice.back();
}