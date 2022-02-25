import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla/features/favorites/data/models/favorite_model.dart';
import 'package:salla/features/favorites/data/models/favorites_data_products_model.dart';
import 'package:salla/features/favorites/data/repositories/favorites_repo_impl.dart';

part 'favorites_event.dart';

part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepoImp favoritesRepoImp;

  FavoritesBloc({required this.favoritesRepoImp}) : super(FavoritesInitial()) {
    on<FavoritesEvent>((event, emit) async {
      if (event is GetFavoritesEvent) {
        await favoritesRepoImp.getFavorites().then((value) {
          favoritesProduceList = value.products ?? [];
          emit(FavoritesLoadedSuccessState());
        }).catchError((onError) {
          emit(FavoritesLoadedErrorState());
        });
      }
    });
  }

  static FavoritesBloc get(BuildContext context) => BlocProvider.of(context);
  List<FavoritesProductsModel>? favoritesProduceList ;
}
