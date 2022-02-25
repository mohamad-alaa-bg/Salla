import 'package:salla/features/favorites/data/models/favorite_model.dart';
import 'package:salla/features/favorites/data/models/favorite_change_state.dart';

abstract class FavoritesRepo{
  Future<FavoritesModel> getFavorites();
  Future<FavoriteStateModel> changeProductFavoriteState(int productId);

}