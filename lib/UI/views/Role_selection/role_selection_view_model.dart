import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:stacked/stacked.dart';

class RoleSelectionViewModel extends BaseViewModel {
  final _roleselectionstorage = locator<LocalStorageService>();

  Future<void> savestudentrole() async {
    await _roleselectionstorage.saveuserrole("student");
  }

  Future<void> selectteacherrole() async {
    await _roleselectionstorage.saveuserrole("teacher");
  }
}
