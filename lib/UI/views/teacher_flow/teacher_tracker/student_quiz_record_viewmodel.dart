import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/models/quiz_attempt_model.dart';
import 'package:englify_app/services/tracker_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StudentQuizRecordViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  /// Loaded by the tracker screen and passed straight through — no refetch.
  final StudentTrackerSummary summary;
  StudentQuizRecordViewmodel(this.summary);

  List<QuizAttemptRecord> get attempts => summary.attempts;

  void onQuizTap(QuizAttemptRecord attempt) {
    _navigationService.navigateToQuizAttemptDetailView(attempt: attempt);
  }

  void onBack() => _navigationService.back();
}
