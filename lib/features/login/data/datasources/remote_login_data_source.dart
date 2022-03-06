import 'package:dio/dio.dart';
import 'package:salla/core/data/remote_data_source.dart';
import 'package:salla/features/login/data/models/login_data.dart';
import 'package:salla/features/login/data/models/shop_login_model.dart';

abstract class RemoteLoginDataSource{
  Future<ShopLoginModel> postData({required String url, required Map<dynamic, dynamic> data});

}

class RemoteLoginDataSourceImp implements RemoteLoginDataSource{

  @override
  Future<ShopLoginModel> postData({required String url, required Map<dynamic, dynamic> data}) async{
    Response response = await DioHelper.postData(url: url,data: data);
    ShopLoginModel loginModel = ShopLoginModel.fromJson(response);
    print(response.data['status']);
    return loginModel;
  }
}