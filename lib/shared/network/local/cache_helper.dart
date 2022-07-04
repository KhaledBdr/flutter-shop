import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    String key,
    dynamic value,
  }) {
    if (value is String) return sharedPreferences?.setString(key, value);
    if (value is bool) return sharedPreferences?.setBool(key, value);
    if (value is int) return sharedPreferences?.setInt(key, value);

    return sharedPreferences?.setDouble(key, value);
  }

  static dynamic getData({
    String key,
  }) {
    return sharedPreferences?.get(key);
  }

  static dynamic deleteData({
    String key,
  }) {
    return sharedPreferences?.remove(key);
  }


  static Future<bool> changeData({
    String key,
    dynamic value,
  }) {
    sharedPreferences?.remove(key);
    if (value is String) return sharedPreferences?.setString(key, value);
    if (value is bool) return sharedPreferences?.setBool(key, value);
    if (value is int) return sharedPreferences?.setInt(key, value);
    if (value is Null) return sharedPreferences?.setBool(key, false);
    return sharedPreferences?.setDouble(key, value);
  }
}