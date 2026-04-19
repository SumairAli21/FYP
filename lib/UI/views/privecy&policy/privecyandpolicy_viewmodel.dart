import 'package:englify_app/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PrivecyandpolicyViewmodel extends BaseViewModel {
  final _navigationservice = locator<NavigationService>();

  void onback() {
    _navigationservice.back();
  }
}
