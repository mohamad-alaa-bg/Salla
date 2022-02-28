import 'package:salla/core/data/local_data_source/shared_preferences.dart';
import 'package:salla/core/util/enum.dart';

class EndPoints {
  static const login = 'login';
  static const home = 'home';
  static const categories = 'categories';
  static const favorite = 'favorites';
  static const profile = 'profile';
}

class UserData {
  static final bool onBoardingState =
      SharedPreferencesCache.getValue(key: 'onBoarding') ?? true;
  static String token = SharedPreferencesCache.getValue(key: 'token') ?? '';

  static ThemeModeSetting themeMode =
      (SharedPreferencesCache.getValue(key: 'mode') == null) ||
              (SharedPreferencesCache.getValue(key: 'mode') == false)
          ? ThemeModeSetting.light
          : ThemeModeSetting.dark;
}
