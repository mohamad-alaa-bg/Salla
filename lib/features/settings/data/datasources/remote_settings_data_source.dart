import 'package:dio/dio.dart';
import 'package:salla/core/data/remote_data_source.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/features/settings/data/models/settings_model.dart';

abstract class RemoteSettingsDataSource{
  Future<SettingsModel> getSetting();

}
class RemoteSettingsDataSourceImp implements RemoteSettingsDataSource{
  @override
  Future<SettingsModel> getSetting() async{
    Response response = await DioHelper.getData(url: EndPoints.profile,token: UserData.token);
    return SettingsModel.fromJson(response);

  }
  
}