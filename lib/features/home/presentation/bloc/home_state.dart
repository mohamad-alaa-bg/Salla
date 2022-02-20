part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class BottomNavigatorItemState extends HomeState {}

class HomePageDataIsLoading extends HomeState {}

class HomePageDataSuccess extends HomeState {
  final HomeModel homeData;

  HomePageDataSuccess({required this.homeData});
}

class HomePageDataError extends HomeState{

}
