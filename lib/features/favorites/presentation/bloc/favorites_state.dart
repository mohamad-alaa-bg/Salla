part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}
class FavoritesDeleteSuccess extends FavoritesState{}
class FavoritesDeleteWarning extends FavoritesState{
  final String message;

  FavoritesDeleteWarning({required this.message});
}
class FavoritesDeleteError extends FavoritesState{}
