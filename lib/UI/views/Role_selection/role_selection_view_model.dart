import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoleSelectionViewModel extends BaseViewModel {
  final _roleselectionstorage = locator<LocalStorageService>();
  final _navigationservice = locator<NavigationService>();

  Future<void> savestudentrole() async {
    await _roleselectionstorage.saveuserrole("student");
     _navigationservice.replaceWithAuthView();
  }

  Future<void> selectteacherrole() async {
    await _roleselectionstorage.saveuserrole("teacher");
    _navigationservice.replaceWithAuthView();
  }
}
