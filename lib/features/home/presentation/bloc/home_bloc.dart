import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      if(event is ChangeBottomBarItemEvent){
        bottomNavigatorIndex = event.index;
        emit(BottomNavigatorItemState());
      }
      // TODO: implement event handler
    });
  }

  static HomeBloc get(context) => BlocProvider.of(context);
   int bottomNavigatorIndex =0;

   List<BottomNavigationBarItem> bottomNavigatorItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
   List<Widget> bottomNavigatorScreens = const [
     Text('1'),
     Text('2'),
     Text('3'),
     Text('4'),
   ];
}
