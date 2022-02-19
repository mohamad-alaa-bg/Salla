import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesCache {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setValue({required String key, required dynamic value}) async {
    if (value is bool) {
       return sharedPreferences!.setBool(key, value);
    }
    if (value is int) {
      return sharedPreferences!.setInt(key, value);
    }
    if (value is double) {
      return sharedPreferences!.setDouble(key, value);
    }
    else {
      return sharedPreferences!.setString(key, value);
    }
  }

  static dynamic getValue({required String key}) {
    final data = sharedPreferences?.get(key);
    return data;
  }

  static Future<bool> removeValue({required String key}){
    return sharedPreferences!.remove(key);
  }
}
