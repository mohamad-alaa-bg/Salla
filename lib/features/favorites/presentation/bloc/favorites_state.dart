part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}
class FavoritesLoadedSuccessState extends FavoritesState{
}
class FavoritesLoadedErrorState extends FavoritesState{}
class FavoriteDeleteSuccessState extends FavoritesState{}
class FavoriteDeleteWarningState extends FavoritesState{
  final String message;

  FavoriteDeleteWarningState({required this.message});
}
class FavoriteDeleteErrorState extends FavoritesState{}
