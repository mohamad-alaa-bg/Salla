import 'package:salla/core/data/local_data_source/shared_preferences.dart';
import 'package:salla/core/util/enum.dart';

class EndPoints {
  static const login = 'login';
  static const register = 'register';
  static const home = 'home';
  static const categories = 'categories';
  static const search = 'products/search';
  static const favorite = 'favorites';
  static const profile = 'profile';
  static const updateProfile = 'update-profile';
}

class UserData {
  static bool onBoardingState =
      SharedPreferencesCache.getValue(key: 'onBoarding') ?? true;
  static String token = SharedPreferencesCache.getValue(key: 'token') ?? '';

  static ThemeModeSetting themeMode =
      (SharedPreferencesCache.getValue(key: 'mode') == null) ||
              (SharedPreferencesCache.getValue(key: 'mode') == false)
          ? ThemeModeSetting.light
          : ThemeModeSetting.dark;

  static Language language =
      (SharedPreferencesCache.getValue(key: 'lang') == null) ||
              (SharedPreferencesCache.getValue(key: 'lang') == 'en')
          ? Language.english
          : Language.arabic;
}
