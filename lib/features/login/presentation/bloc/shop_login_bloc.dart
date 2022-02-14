import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shop_login_event.dart';
part 'shop_login_state.dart';

class ShopLoginBloc extends Bloc<ShopLoginEvent, ShopLoginState> {
  ShopLoginBloc() : super(ShopLoginInitial()) {
    on<ShopLoginEvent>((event, emit) {

    });
  }
}
