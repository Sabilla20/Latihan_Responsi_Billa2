import 'package:shared_preferences/shared_preferences.dart';

/// Penyimpanan informasi login memakai SharedPreferences.
class AuthService {
  static const _kEmail = 'email';
  static const _kPassword = 'password';
  static const _kLoggedIn = 'is_logged_in';

  static Future<void> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kEmail, email);
    await prefs.setString(_kPassword, password);
    await prefs.setBool(_kLoggedIn, true);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kLoggedIn) ?? false;
  }

  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kEmail) ?? '-';
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kLoggedIn, false);
    await prefs.remove(_kEmail);
    await prefs.remove(_kPassword);
  }
}
