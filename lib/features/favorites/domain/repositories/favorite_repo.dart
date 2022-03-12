import 'package:salla/core/util/enum.dart';
import 'package:salla/features/favorites/data/models/favorite_model.dart';
import 'package:salla/features/favorites/data/models/favorite_change_state.dart';

abstract class FavoritesRepo{
  Future<FavoritesModel> getFavorites(Language lang);
  Future<FavoriteStateModel> changeProductFavoriteState(int productId);

}