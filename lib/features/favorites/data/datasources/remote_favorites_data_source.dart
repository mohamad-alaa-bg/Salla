import 'package:dio/dio.dart';
import 'package:salla/core/data/remote_data_source.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/features/favorites/data/models/favorite_model.dart';

abstract class RemoteFavoritesDataSource {
   Future<FavoritesModel> getFavorites();

}
class RemoteFavoritesDataSourceImp implements RemoteFavoritesDataSource {
  @override
  Future<FavoritesModel> getFavorites() async{
    Response response = await DioHelper.getData(url: EndPoints.favorite,token: UserData.token);
    return FavoritesModel.fromJson(response);
  }
}