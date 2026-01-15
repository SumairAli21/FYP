import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplachViewModel extends BaseViewModel {
  final _splachstorage = locator<LocalStorageService>();
  final _navigationservice = locator<NavigationService>();

  Future<void> runsetuplogic() async {
    await Future.delayed(Duration(seconds: 3));

    final isfirstlaunch = await _splachstorage.isfirstlaunch();

    if (isfirstlaunch) {
      _navigationservice.replaceWithOnbordingView();
    } else {
      _navigationservice.replaceWithRoleSelection();
    }
  }
}
