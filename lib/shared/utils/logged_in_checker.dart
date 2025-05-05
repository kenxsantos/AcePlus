import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static final ValueNotifier<bool> isLoggedInNotifier = ValueNotifier(false);

  static void setLoggedIn(bool value) {
    isLoggedInNotifier.value = value;
  }

  static bool isLoggedIn() {
    return isLoggedInNotifier.value;
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    return userId?.toString();
  }
}