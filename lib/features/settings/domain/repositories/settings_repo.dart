import 'package:salla/features/settings/data/models/settings_model.dart';

abstract class SettingsRepo{
  Future<SettingsModel> getSetting();
   Future<SettingsModel> updateSetting(String name, String email, String phone);
}