import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'login_data.dart';

class ShopLoginModel {
  final bool status;
  final String message;
  final LoginData? data;

  ShopLoginModel({
    required this.status,
    required this.message,
    this.data,
  });


  factory ShopLoginModel.fromJson(Response response){
     return ShopLoginModel(
      status: response.data['status'],
      message: response.data['message'],
      data: response.data['data'] == null ? null : LoginData.fromJson(response.data['data']),
    );

  }
}
