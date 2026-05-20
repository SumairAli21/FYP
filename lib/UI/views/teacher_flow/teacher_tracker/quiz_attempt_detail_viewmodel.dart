import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/models/quiz_attempt_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class QuizAttemptDetailViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  /// The full attempt (questions + selected/correct answers) passed in by the
  /// student quiz-record screen.
  final QuizAttemptRecord attempt;
  QuizAttemptDetailViewmodel(this.attempt);

  void onBack() => _navigationService.back();
}
