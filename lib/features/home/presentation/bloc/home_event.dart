part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class ChangeBottomBarItemEvent extends HomeEvent{
  final int index;
  ChangeBottomBarItemEvent({required this.index});
}

class GetHomePageDataEvent extends HomeEvent{}
