import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesCache {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static setValue({required String key, required dynamic value}) async {
    if (value is bool) {
      await sharedPreferences?.setBool(key, value);
    }
    if (value is int) {
      await sharedPreferences?.setInt(key, value);
    }
    if (value is double) {
      await sharedPreferences?.setDouble(key, value);
    }
    if (value is String) {
      await sharedPreferences?.setString(key, value);
    }
  }

  static dynamic getValue({required String key}) {
    final data = sharedPreferences?.get(key);
    return data;
  }
}
