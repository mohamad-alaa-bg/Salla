part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}
class FavoritesLoadedSuccessState extends FavoritesState{
}
class FavoritesIsLoadingState extends FavoritesState{}
class FavoritesLoadedErrorState extends FavoritesState{}
class FavoriteDeleteSuccessState extends FavoritesState{}
class FavoriteDeleteWarningState extends FavoritesState{
  final String message;

  FavoriteDeleteWarningState({required this.message});
}
class FavoriteDeleteErrorState extends FavoritesState{}

class FavoriteChangeSuccess extends FavoritesState{}
class FavoriteChangeWarning extends FavoritesState{
  final String message;
  FavoriteChangeWarning({required this.message});

}
class FavoriteChangeError extends FavoritesState{}


