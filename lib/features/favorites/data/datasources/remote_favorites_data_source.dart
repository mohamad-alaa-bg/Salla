import 'package:dio/dio.dart';
import 'package:salla/core/data/remote_data_source.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/core/util/enum.dart';
import 'package:salla/features/favorites/data/models/favorite_model.dart';
import 'package:salla/features/favorites/data/models/favorite_change_state.dart';

abstract class RemoteFavoritesDataSource {
  Future<FavoritesModel> getFavorites(Language lang);

  Future<FavoriteStateModel> changeFavoriteState(int productId);
}

class RemoteFavoritesDataSourceImp implements RemoteFavoritesDataSource {
  @override
  Future<FavoritesModel> getFavorites(Language lang) async {
    Response response = await DioHelper.getData(
        url: EndPoints.favorite,
        token: UserData.token,
        lang: lang == Language.english ? 'en' : 'ar');
    return FavoritesModel.fromJson(response);
  }

  @override
  Future<FavoriteStateModel> changeFavoriteState(int productId) async {
    Response response = await DioHelper.postData(
      url: EndPoints.favorite,
      token: UserData.token,
      data: {'product_id': productId},
    );
    return FavoriteStateModel.fomJson(response);
  }
}
