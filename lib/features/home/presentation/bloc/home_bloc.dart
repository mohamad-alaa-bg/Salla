import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/features/categories/presentation/pages/categories_page.dart';
import 'package:salla/features/favorites/presentation/pages/FavoriteScreen.dart';
import 'package:salla/features/home/data/models/favorite_change_state.dart';
import 'package:salla/features/home/data/models/home_data_model.dart';
import 'package:salla/features/home/data/models/home_model.dart';
import 'package:salla/features/home/data/repositories/home_page_repo_imp.dart';
import 'package:salla/features/home/presentation/pages/product_Screen.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomePageRepoImp homePageRepoImp;

  HomeBloc({required this.homePageRepoImp}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is ChangeBottomBarItemEvent) {
        bottomNavigatorIndex = event.index;
        emit(BottomNavigatorItemState());
      }
      if (event is GetHomePageDataEvent) {
        emit(HomePageDataIsLoading());
        try {
          homeData = await homePageRepoImp.getHomeData();
          for (var e in homeData!.data.products) {
            favorite.addAll({e.id: e.inFavorites});
          }
          emit(HomePageDataSuccess(homeData: homeData));
        } catch (error) {
          HomePageDataError();
        }
      }
      if (event is ChangeProductFavoriteState) {
        favorite[event.productId] =
            favorite[event.productId] == false ? true : false;
        emit(FavoriteChangeSuccess());
        try {
          FavoriteStateModel favoriteState =
              await homePageRepoImp.changeProductFavoriteState(event.productId);
          if (favoriteState.status == false) {
            favorite[event.productId] =
                favorite[event.productId] == false ? true : false;
            emit(FavoriteChangeWarning(message: favoriteState.message));
          }
        } catch (error) {
          print(error);
          emit(FavoriteChangeError());
        }
      }
      // TODO: implement event handler
    });
  }

  Map<int, bool> favorite = {};

  HomeModel? homeData;

  static HomeBloc get(context) => BlocProvider.of(context);
  int bottomNavigatorIndex = 0;

  List<BottomNavigationBarItem> bottomNavigatorItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  List<Widget> bottomNavigatorScreens = const [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    Text('4'),
  ];
}
