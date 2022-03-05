import 'package:salla/features/settings/data/datasources/remote_settings_data_source.dart';
import 'package:salla/features/settings/data/models/settings_model.dart';
import 'package:salla/features/settings/domain/repositories/settings_repo.dart';

class SettingsRepoImp implements SettingsRepo {
  RemoteSettingsDataSourceImp remoteSettingsDataSourceImp =
      RemoteSettingsDataSourceImp();

  @override
  Future<SettingsModel> getSetting() async {
    return await remoteSettingsDataSourceImp.getSetting();
  }

  @override
  Future<SettingsModel> updateSetting(
      String name, String email, String phone) async {
    return await remoteSettingsDataSourceImp.updateSetting(name, email, phone);
  }
}
