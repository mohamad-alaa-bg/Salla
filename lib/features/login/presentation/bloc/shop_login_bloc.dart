import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla/core/data/local_data_source/shared_preferences.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/features/login/data/models/shop_login_model.dart';
import 'package:salla/features/login/data/repositories/shop_login_repo_imp.dart';
import 'package:salla/features/login/domain/repositories/shop_login_repo.dart';

part 'shop_login_event.dart';

part 'shop_login_state.dart';

class ShopLoginBloc extends Bloc<ShopLoginEvent, ShopLoginState> {
  final ShopLoginRepo shopLoginRepo;
  bool obscurePassword = true;
  Widget suffixIcon = const Icon(Icons.visibility_outlined);

  ShopLoginBloc({required this.shopLoginRepo}) : super(ShopLoginInitial()) {
    on((event, emit) async {
      if (event is ShopUserLoginEvent) {
        emit(ShopLoginLoadingState());
        try {
          ShopLoginModel loginResponse =
          await shopLoginRepo.userLogin(url: EndPoints.login, data: {
            'email': event.email,
            'password': event.password,
          });
          if (loginResponse.data?.token != null) {
            SharedPreferencesCache.setValue(
                key: 'token', value: loginResponse.data?.token);
            UserData.token = SharedPreferencesCache.getValue(key: 'token');
          }

          //print(loginResponse.data!.email);
          emit(ShopLoginSucceededState(loginModel: loginResponse));
        } catch (error) {
          print(error);
          emit(ShopLoginErrorState());
        }
      } else if (event is LoginChangePasswordVisibilityEvent) {
        obscurePassword = !obscurePassword;
        suffixIcon = obscurePassword
            ? const Icon(Icons.visibility_outlined)
            : const Icon(Icons.visibility_off_outlined);
        emit(LoginChangedPasswordVisibilityState());
      } else if (event is ShopUserRegisterEvent) {
        emit(ShopLoginLoadingState());
        try {
          ShopLoginModel loginResponse =
          await shopLoginRepo.userRegister(name: event.name.toString(),
              email: event.email.toString(),
              password: event.password.toString(),
              phone: "0974056564");
          if (loginResponse.data?.token != null) {
            SharedPreferencesCache.setValue(
                key: 'token', value: loginResponse.data?.token);
            UserData.token = SharedPreferencesCache.getValue(key: 'token');
          }

          //print(loginResponse.data!.email);
          emit(ShopLoginSucceededState(loginModel: loginResponse));
        } catch (error) {
          print(error);
          emit(ShopLoginErrorState());
        }
      }
    });
  }

  Stream<ShopLoginState> mapEventToState(ShopLoginEvent event) async* {
    if (event is ShopUserLoginEvent) {}
  }
}
