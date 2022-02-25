import 'package:salla/features/favorites/data/models/favorite_model.dart';

abstract class FavoritesRepo{
  Future<FavoritesModel> getFavorites();
}