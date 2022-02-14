part of 'shop_login_bloc.dart';

@immutable
abstract class ShopLoginEvent {}

class ShopUserLogin extends ShopLoginEvent {
  final String? email;
  final String? password;

  ShopUserLogin({
    this.email,
    this.password,
  });
}
