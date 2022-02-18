import 'package:dio/src/response.dart';
import 'package:salla/features/login/data/datasources/remote_login_data_source.dart';
import 'package:salla/features/login/data/models/shop_login_model.dart';
import 'package:salla/features/login/domain/repositories/shop_login_repo.dart';

class ShopLoginRepoImp implements ShopLoginRepo{
  RemoteLoginDataSourceImp remoteLoginDataSource = RemoteLoginDataSourceImp();
  @override
  Future<ShopLoginModel> userLogin({required String url, required Map<dynamic, dynamic> data}) {
    return remoteLoginDataSource.postData(url: url,data: data);
  }
}