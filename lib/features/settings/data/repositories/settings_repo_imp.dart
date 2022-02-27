import 'package:salla/features/settings/data/datasources/remote_settings_data_source.dart';
import 'package:salla/features/settings/data/models/settings_model.dart';
import 'package:salla/features/settings/domain/repositories/settings_repo.dart';

class SettingsRepoImp implements SettingsRepo{
  @override
  Future<SettingsModel> getSetting() async{
    RemoteSettingsDataSourceImp remoteSettingsDataSourceImp = RemoteSettingsDataSourceImp();
    return await remoteSettingsDataSourceImp.getSetting();
  }
}