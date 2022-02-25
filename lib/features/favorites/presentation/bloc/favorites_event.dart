part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent {}

class RemoveProductFavoriteEvent extends FavoritesEvent {
  final int id;


  RemoveProductFavoriteEvent({required this.id});
}
class GetFavoritesEvent extends FavoritesEvent{}

class ChangeProductFavoriteState extends FavoritesEvent{
  final int productId;
  final ProductModel productModel;

  ChangeProductFavoriteState({required this.productId,required this.productModel});
}