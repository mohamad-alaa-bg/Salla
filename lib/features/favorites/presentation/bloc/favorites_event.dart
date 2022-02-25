part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent {}

class RemoveProductFavorite extends FavoritesEvent {
  final int id;

  RemoveProductFavorite({required this.id});
}
