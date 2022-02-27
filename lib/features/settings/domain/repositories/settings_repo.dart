import 'package:salla/features/settings/data/models/settings_model.dart';

abstract class SettingsRepo{
  Future<SettingsModel> getSetting();
}