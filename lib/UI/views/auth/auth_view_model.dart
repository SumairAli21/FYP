import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthViewModel extends BaseViewModel {
  final _navigationservice = locator<NavigationService>();

  void continuewithemail() {
    _navigationservice.navigateToSignupemailview();
  }
}
