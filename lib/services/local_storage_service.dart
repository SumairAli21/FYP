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

  // user islogin?
  static const _isloginKey = "islogin";

  Future<bool> getislogin() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(_isloginKey) ?? false;
  }

  Future<void> islogintrue() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(_isloginKey, true);
  }

  // future need
  Future<void> isloginfalse() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(_isloginKey, false);
  }

  // user personalization
  static const _usernamekey = "user_name";

  Future<void> saveusername(String name) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_usernamekey, name);
  }

  Future<String?> getusername() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_usernamekey);
  }

  Future<void> clearuserdata() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  // isclassroom join
  static const classroomKey = "isclassroom_join";

  Future<void> setclassroomjointrue() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(classroomKey, true);
  }

  Future<bool> isclassroomjoined() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(classroomKey) ?? false;
  }
}
