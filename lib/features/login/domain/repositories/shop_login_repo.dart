import 'package:salla/features/login/data/models/shop_login_model.dart';

abstract class ShopLoginRepo {
  Future<ShopLoginModel> userLogin(
      {required String url, required Map<dynamic, dynamic> data});

  Future<ShopLoginModel> userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone});
}
