import 'package:salla/core/util/enum.dart';
import 'package:salla/features/favorites/data/datasources/remote_favorites_data_source.dart';
import 'package:salla/features/favorites/data/models/favorite_model.dart';
import 'package:salla/features/favorites/domain/repositories/favorite_repo.dart';
import 'package:salla/features/favorites/data/models/favorite_change_state.dart';

class FavoritesRepoImp implements FavoritesRepo {
  @override
  Future<FavoritesModel> getFavorites(Language lang) async {
    RemoteFavoritesDataSourceImp remoteFavoritesDataSourceImp =
        RemoteFavoritesDataSourceImp();
    return await remoteFavoritesDataSourceImp.getFavorites(lang);
  }

  @override
  Future<FavoriteStateModel> changeProductFavoriteState(int productId) {
    RemoteFavoritesDataSourceImp remoteFavoritesDataSourceImp =
    RemoteFavoritesDataSourceImp();
    return remoteFavoritesDataSourceImp.changeFavoriteState(productId);
  }
}
