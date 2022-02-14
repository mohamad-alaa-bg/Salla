import 'package:dio/dio.dart';
import 'package:salla/core/data/remote_data_source.dart';

abstract class RemoteLoginDataSource{
  Future<Response> postData({required String url, required Map<dynamic, dynamic> data});
}

class RemoteLoginDataSourceImp implements RemoteLoginDataSource{

  @override
  Future<Response> postData({required String url, required Map<dynamic, dynamic> data}) async{
    return await DioHelper.postData(url: url,data: data);
  }
}