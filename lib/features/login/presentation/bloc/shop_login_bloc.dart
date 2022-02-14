import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/features/login/data/repositories/shop_login_repo_imp.dart';

part 'shop_login_event.dart';

part 'shop_login_state.dart';

class ShopLoginBloc extends Bloc<ShopLoginEvent, ShopLoginState> {
  final ShopLoginRepoImp shopLoginRepoImp;

  ShopLoginBloc({required this.shopLoginRepoImp}) : super(ShopLoginInitial()) {
    on((event, emit) async {
      if (event is ShopUserLoginEvent) {
        emit(ShopLoginLoadingState());
        try {
          Response response =
              await shopLoginRepoImp.userLogin(url: EndPoints.login, data: {
            'email': event.email,
            'password': event.password,
          });
          print(response);
          emit(ShopLoginSucceededState());
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
