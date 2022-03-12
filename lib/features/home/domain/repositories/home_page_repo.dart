import 'package:salla/core/util/enum.dart';
import 'package:salla/features/favorites/data/models/favorite_change_state.dart';
import 'package:salla/features/home/data/models/home_model.dart';

abstract class HomePageRepo{
  HomePageRepo(){
    print('create Home Repo');
  }
  Future<HomeModel> getHomeData(Language lang);
}