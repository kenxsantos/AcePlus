import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    return userId?.toString();
  }
}