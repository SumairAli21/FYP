import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _firstLaunchKey = 'first_launch';
  // first launch(user open app for first time or not ?)
  Future<bool> isfirstlaunch() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(_firstLaunchKey) ?? true;
  }

  Future<void> setfirstlaunchfalse() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(_firstLaunchKey, false);
  }

  // role selection
  static const _userRoleKey = 'user_role';

  Future<String?> getuserrole() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_userRoleKey);
  }

  Future<void> saveuserrole(String role) async {
    final perf = await SharedPreferences.getInstance();
    await perf.setString(_userRoleKey, role);
  }

  Future<void> clearuserrole() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_userRoleKey);
  }
}
