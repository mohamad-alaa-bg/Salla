import 'package:salla/features/home/data/models/favorite_change_state.dart';
import 'package:salla/features/home/data/models/home_model.dart';

abstract class HomePageRepo{
  Future<HomeModel> getHomeData();
  Future<FavoriteStateModel> changeProductFavoriteState(int productId);
}