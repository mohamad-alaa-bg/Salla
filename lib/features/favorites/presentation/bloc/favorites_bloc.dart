import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/core/util/enum.dart';
import 'package:salla/features/favorites/data/models/favorites_data_products_model.dart';
import 'package:salla/features/favorites/data/models/favorite_change_state.dart';
import 'package:salla/features/favorites/domain/repositories/favorite_repo.dart';
import 'package:salla/features/home/data/models/product_model.dart';

part 'favorites_event.dart';

part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepo favoritesRepo;

  FavoritesBloc({required this.favoritesRepo}) : super(FavoritesInitial()) {
    on<FavoritesEvent>((event, emit) async {
      if (event is GetFavoritesEvent) {
        emit(FavoritesIsLoadingState());
        favoritesProduceList = null;
        favoritesProduceListEn = null;
        favoritesProduceListAr = null;
        await favoritesRepo.getFavorites(UserData.language).then((value) async {
          favoritesProduceList = value.products ?? [];
          if (UserData.language == Language.english) {
            favoritesProduceListEn = favoritesProduceList;
          } else {
            favoritesProduceListAr = favoritesProduceList;
          }
          favoritesProduceListSaved = value.products ?? [];
          for (var e in value.products ?? []) {
            favorite.addAll({e.id: e.inFavorites});
          }
          emit(FavoritesLoadedSuccessState());
          if (UserData.language == Language.english) {
            await favoritesRepo
                .getFavorites(Language.arabic)
                .then((value) => favoritesProduceListAr = value.products);
          } else {
            await favoritesRepo
                .getFavorites(Language.english)
                .then((value) => favoritesProduceListEn = value.products);
          }
        }).catchError((onError) {
          emit(FavoritesLoadedErrorState());
        });
      }
      if (event is ChangeProductFavoriteState) {
        if (favorite.containsKey(event.productId)) {
          favorite.update(event.productId, (value) {
            if (value == true) {
              favoritesProduceList
                  ?.removeWhere((element) => element.id == event.productId);
              favoritesProduceListEn
                  ?.removeWhere((element) => element.id == event.productId);
              favoritesProduceListAr
                  ?.removeWhere((element) => element.id == event.productId);
            }
            return value == false ? true : false;
          });
        } else {
          favorite.addAll({event.productId: true});
        }

        emit(FavoriteChangeSuccess());
        try {
          FavoriteStateModel favoriteState =
              await favoritesRepo.changeProductFavoriteState(event.productId);
          if (favoriteState.status == false) {
            if (favorite[event.productId] == false) {
              favoritesProduceList?.add(FavoritesProductsModel(
                id: event.productModel.id,
                name: event.productModel.name,
                imageStr: event.productModel.imageStr,
                price: event.productModel.price,
                oldPrice: event.productModel.oldPrice,
                discount: event.productModel.discount ?? 0,
                description: event.productModel.description,
              ));

              emit(FavoritesLoadedSuccessState());
            }
            favorite[event.productId] =
                favorite[event.productId] == false ? true : false;

            emit(FavoriteChangeWarning(message: favoriteState.message));
          } else {
            if ((favorite.containsKey(event.productId))) {
              if (favorite[event.productId] == true) {
                favoritesProduceList?.add(FavoritesProductsModel(
                    id: event.productModel.id,
                    name: event.productModel.name,
                    imageStr: event.productModel.imageStr,
                    price: event.productModel.price,
                    oldPrice: event.productModel.oldPrice,
                    discount: event.productModel.discount ?? 0,
                    description: event.productModel.description));

                emit(FavoritesLoadedSuccessState());
              }
            }
          }
        } catch (error) {
          print(error);
          emit(FavoriteChangeError());
        }
      }
    });
  }

  Map<int, bool> favorite = {};

  static FavoritesBloc get(BuildContext context) => BlocProvider.of(context);
  List<FavoritesProductsModel>? favoritesProduceList;
  List<FavoritesProductsModel>? favoritesProduceListEn;
  List<FavoritesProductsModel>? favoritesProduceListAr;
  List<FavoritesProductsModel>? favoritesProduceListSaved;
}
