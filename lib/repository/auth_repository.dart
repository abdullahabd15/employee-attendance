import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  var _prefs = SharedPreferences.getInstance();
  static const current_user_login = "current_user_login";

  void setCurrentUserLogin(int employeeId) async {
    var prefs = await _prefs;
    prefs.setInt(current_user_login, employeeId);
  }

  Future<int> currentUserLogin() async {
    var prefs = await _prefs;
    var userId = prefs.getInt(current_user_login);
    return userId;
  }

  Future<bool> removeCurrentUserLogin() async {
    var prefs = await _prefs;
    return prefs.remove(current_user_login);
  }
}