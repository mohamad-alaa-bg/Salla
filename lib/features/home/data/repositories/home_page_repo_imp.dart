import 'package:salla/core/util/enum.dart';
import 'package:salla/features/home/data/datasources/remote_home_page_data.dart';
import 'package:salla/features/favorites/data/models/favorite_change_state.dart';
import 'package:salla/features/home/data/models/home_model.dart';
import 'package:salla/features/home/domain/repositories/home_page_repo.dart';

class HomePageRepoImp implements HomePageRepo{
  HomePageRepoImp(){
    print('create Home Repo Imp');
  }
  RemoteHomePageDataImp remoteHomePageDataImp = RemoteHomePageDataImp();
  @override
  Future<HomeModel> getHomeData(Language lang) {

    return remoteHomePageDataImp.getHomeData( lang);
  }


}