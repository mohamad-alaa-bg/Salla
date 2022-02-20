import 'package:salla/core/data/local_data_source/shared_preferences.dart';

class EndPoints {
  static const login = 'login';
  static const home = 'home';
}

class UserData {
  static final bool onBoardingState =
      SharedPreferencesCache.getValue(key: 'onBoarding') ?? true;
  static final String token =
      SharedPreferencesCache.getValue(key: 'token') ?? '';

}
