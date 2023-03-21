import 'package:shared_preferences/shared_preferences.dart';

class myThemePreferences {
  static const uniqueKey = "uniquekey";

  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(uniqueKey, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(uniqueKey) ?? false;
  }
}
