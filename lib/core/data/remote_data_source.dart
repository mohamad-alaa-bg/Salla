import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:salla/core/util/constants.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'lang' : 'ar',
          'Content-Type' : 'application/json',
        }
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<dynamic, dynamic> data,
    String lang = 'en',
    String? token,
    Map<String, dynamic>? query,

  }) async {
    dio?.options.headers = {
      'lang' : lang,
      'Authorization' : token,
    };
    Response response = await dio!.post(
      url,
      data: data,
      queryParameters: query,

    );
    print(response);
    return response;
  }
}
