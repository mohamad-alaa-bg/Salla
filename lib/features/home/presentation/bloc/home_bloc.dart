import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/features/home/data/models/home_data_model.dart';
import 'package:salla/features/home/data/models/home_model.dart';
import 'package:salla/features/home/data/repositories/home_page_repo_imp.dart';
import 'package:salla/features/products/presentation/pages/product_Screen.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomePageRepoImp homePageRepoImp;
  HomeBloc({required this.homePageRepoImp}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async{
      if(event is ChangeBottomBarItemEvent){
        bottomNavigatorIndex = event.index;
        emit(BottomNavigatorItemState());
      }
      if(event is GetHomePageDataEvent) {
        emit(HomePageDataIsLoading());
        try{
          HomeModel homeData = await homePageRepoImp.getHomeData();
          print(oldHomeData == homeData);
          if (oldHomeData != homeData ){
            // oldHomeData = homeData;
            emit(HomePageDataSuccess(homeData: homeData));
          }

        }catch(error){
          HomePageDataError();
        }
      }
      // TODO: implement event handler
    });
  }
  HomeModel oldHomeData = HomeModel(status: false, data:HomeDataModel(banners:[] ,products: []) );
  static HomeBloc get(context) => BlocProvider.of(context);
   int bottomNavigatorIndex =0;

   List<BottomNavigationBarItem> bottomNavigatorItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
   List<Widget> bottomNavigatorScreens = const [
     ProductsScreen(),
     Text('2'),
     Text('3'),
     Text('4'),
   ];
}
