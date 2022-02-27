import 'package:dio/dio.dart';
import 'package:salla/core/util/enum.dart';
import 'package:salla/features/login/data/models/login_data.dart';
import 'package:salla/features/login/data/models/shop_login_model.dart';

class SettingsModel extends ShopLoginModel {
  @override
  final String message;
  final bool status;
  final LoginData? data;
  final ThemeModeSetting mode ;
  final String lang ;

  SettingsModel({required this.message, required this.status, this.data,this.lang = 'ar',this.mode = ThemeModeSetting.light})
      : super(message: message, status: status, data: data);

  factory SettingsModel.fromJson(Response response){
    return SettingsModel(
      status: response.data['status'],
      message: response.data['message']??'',
      data: response.data['data'] == null ? null : LoginData.fromJson(response.data['data']),
    );

  }

}

