import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static const String isLoggedInKey = 'isLoggedIn';
  static const String userIdKey = 'userId';

  static Future<void> setLoggedIn(bool isLoggedIn, int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, isLoggedIn);
    await prefs.setInt(userIdKey, userId);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(userIdKey);
  }
}
