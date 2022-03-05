import 'package:dio/dio.dart';
import 'package:salla/core/data/remote_data_source.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/features/settings/data/models/settings_model.dart';

abstract class RemoteSettingsDataSource {
  Future<SettingsModel> getSetting();

  Future<SettingsModel> updateSetting(String name, String email, String phone);
}

class RemoteSettingsDataSourceImp implements RemoteSettingsDataSource {
  @override
  Future<SettingsModel> getSetting() async {
    Response response =
        await DioHelper.getData(url: EndPoints.profile, token: UserData.token);
    return SettingsModel.fromJson(response);
  }

  @override
  Future<SettingsModel> updateSetting(
      String name, String email, String phone) async {
    Response response = await DioHelper.putData(
      url: EndPoints.updateProfile,
      data: {'name': name, 'email': email, 'phone': phone},
      token: UserData.token,
    );
    return SettingsModel.fromJson(response);
  }
}
