part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent {}

class RemoveProductFavoriteEvent extends FavoritesEvent {
  final int id;


  RemoveProductFavoriteEvent({required this.id});
}
class GetFavoritesEvent extends FavoritesEvent{}