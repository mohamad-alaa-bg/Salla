part of 'shop_login_bloc.dart';

@immutable
abstract class ShopLoginState {}

class ShopLoginInitial extends ShopLoginState {}
class ShopLoginLoadingState extends ShopLoginState{}
class ShopLoginSucceededState extends ShopLoginState{
  final ShopLoginModel loginModel;
  ShopLoginSucceededState({required this.loginModel});
}
class ShopLoginErrorState extends ShopLoginState{}
class LoginChangedPasswordVisibilityState extends ShopLoginState{}