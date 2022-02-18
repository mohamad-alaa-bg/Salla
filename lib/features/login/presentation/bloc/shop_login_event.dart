part of 'shop_login_bloc.dart';

@immutable
abstract class ShopLoginEvent {}

class LoginChangePasswordVisibilityEvent extends ShopLoginEvent{

}
class ShopUserLoginEvent extends ShopLoginEvent {
  final String? email;
  final String? password;

  ShopUserLoginEvent({
    this.email,
    this.password,
  });
}
