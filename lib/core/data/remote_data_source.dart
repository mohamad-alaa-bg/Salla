import 'package:dio/dio.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/core/util/enum.dart';


class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          ),
    );
  }

  static Future<Response> getData(
      {required String url, String lang = 'en', String? token}) async {
    dio?.options.headers = {
      'Content-Type': 'application/json',
      'lang': UserData.language == Language.english ? 'en':'ar',
      'Authorization': token??'',
    };
    Response response = await dio!.get(
      url,
    );
    return response;
  }

  static Future<Response> postData({
    required String url,
    required Map<dynamic, dynamic> data,
    String lang = 'en',
    String? token,
    Map<String, dynamic>? query,
  }) async {
    dio?.options.headers = {
      'Content-Type': 'application/json',
      'lang': UserData.language == Language.english ? 'en':'ar',
      'Authorization': token??'',
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
