import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static clearAll() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  static saveStr(String key, String message) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, message);
  }

  static saveStrList(String key, List<String> message) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList(key, message);
  }

  static readPrefStr(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static readPrefStrList(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList(key);
  }
}
