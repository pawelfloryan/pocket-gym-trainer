import 'package:shared_preferences/shared_preferences.dart';

String? selectedTheme;
List<String> themes = ["light", "dark", "neon", "falcon"];

class ThemeMethods {
  static Future<void> lightTheme() async {
    selectedTheme = themes[0];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("lightMode", 0);
    prefs.setString("selectedTheme", selectedTheme!);
  }

  static Future<void> darkTheme() async {
    selectedTheme = themes[1];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("darkMode", 1);
    prefs.setString("selectedTheme", selectedTheme!);
  }

  static Future<void> neonTheme() async {
    selectedTheme = themes[2];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("neonMode", 2);
    prefs.setString("selectedTheme", selectedTheme!);
  }

  static Future<void> falconTheme() async {
    selectedTheme = themes[3];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("falconMode", 3);
    prefs.setString("selectedTheme", selectedTheme!);
  }
}
