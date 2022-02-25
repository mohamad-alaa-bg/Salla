import 'package:salla/features/home/data/datasources/remote_home_page_data.dart';
import 'package:salla/features/favorites/data/models/favorite_change_state.dart';
import 'package:salla/features/home/data/models/home_model.dart';
import 'package:salla/features/home/domain/repositories/home_page_repo.dart';

class HomePageRepoImp implements HomePageRepo{
  RemoteHomePageDataImp remoteHomePageDataImp = RemoteHomePageDataImp();
  @override
  Future<HomeModel> getHomeData() {

    return remoteHomePageDataImp.getHomeData();
  }


}