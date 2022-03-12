import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
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
        await favoritesRepo.getFavorites().then((value) {
          favoritesProduceList = value.products ?? [];
          favoritesProduceListSaved = value.products ?? [];
          for (var e in value.products ?? []) {
            favorite.addAll({e.id: e.inFavorites});
          }
          emit(FavoritesLoadedSuccessState());
        }).catchError((onError) {
          emit(FavoritesLoadedErrorState());
        });
      }
      if (event is ChangeProductFavoriteState) {
        if (favorite.containsKey(event.productId)) {
          favorite.update(event.productId, (value){
            if(value == true){
              favoritesProduceList
                     ?.removeWhere((element) => element.id == event.productId);
            }
             return value == false ? true : false;
          });
        } else {
          favorite.addAll({event.productId: true});
        }
        // favorite[event.productId] =
        // favorite[event.productId] == false ? true : false;
        //  FavoritesProductsModel? saveProduct;
        //
        // if (favorite[event.productId] == true) {
        //   int index = favoritesProduceListSaved!
        //       .indexWhere((element) => element.id == event.productId);
        //   saveProduct = favoritesProduceListSaved![index];
        //   favoritesProduceList
        //       ?.removeWhere((element) => element.id == event.productId);
        // }

        emit(FavoriteChangeSuccess());
        try {
          FavoriteStateModel favoriteState = await favoritesRepo
              .changeProductFavoriteState(event.productId);
          if (favoriteState.status == false) {
            // if(saveProduct !=null) {
            //   favoritesProduceList?.add(saveProduct);
            // }
            if (favorite[event.productId] == false) {
              favoritesProduceList?.add(FavoritesProductsModel(
                  id: event.productModel.id,
                  name: event.productModel.name,
                  image: event.productModel.image,
                  price: event.productModel.price,
                  oldPrice: event.productModel.oldPrice,
                  discount: event.productModel.discount??0,
                  description: event.productModel.description));
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
                    image: event.productModel.image,
                    price: event.productModel.price,
                    oldPrice: event.productModel.oldPrice,
                    discount: event.productModel.discount??0,
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
  List<FavoritesProductsModel>? favoritesProduceListSaved;
}
