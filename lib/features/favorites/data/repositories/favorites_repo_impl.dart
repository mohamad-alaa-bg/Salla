import 'package:salla/features/favorites/data/datasources/remote_favorites_data_source.dart';
import 'package:salla/features/favorites/data/models/favorite_model.dart';
import 'package:salla/features/favorites/domain/repositories/favorite_repo.dart';

class FavoritesRepoImp implements FavoritesRepo {
  @override
  Future<FavoritesModel> getFavorites() async {
    RemoteFavoritesDataSourceImp remoteFavoritesDataSourceImp =
        RemoteFavoritesDataSourceImp();
    return await remoteFavoritesDataSourceImp.getFavorites();
  }
}
