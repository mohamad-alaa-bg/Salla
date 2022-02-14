import 'package:dio/dio.dart';

abstract class ShopLoginRepo{
  Future<Response> userLogin({required String url, required Map<dynamic, dynamic> data});
}