import 'package:salla/features/home/data/models/home_model.dart';

abstract class HomePageRepo{
  Future<HomeModel> getHomeData();
}