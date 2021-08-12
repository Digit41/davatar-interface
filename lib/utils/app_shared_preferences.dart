import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void setTheme(String the) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('theme', the);
  }

  Future<String?> getTheme() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('theme');
  }
}
