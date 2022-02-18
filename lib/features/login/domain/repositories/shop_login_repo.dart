import 'package:dio/dio.dart';
import 'package:salla/features/login/data/models/shop_login_model.dart';

abstract class ShopLoginRepo{
  Future<ShopLoginModel> userLogin({required String url, required Map<dynamic, dynamic> data});
}