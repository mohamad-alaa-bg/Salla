import 'package:dio/dio.dart';
import 'package:salla/core/data/remote_data_source.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/features/favorites/data/models/favorite_change_state.dart';
import 'package:salla/features/home/data/models/home_model.dart';

abstract class RemoteHomePageData {
  Future<HomeModel> getHomeData();

}

class RemoteHomePageDataImp implements RemoteHomePageData {
  @override
  Future<HomeModel> getHomeData() async {
    Response response =
        await DioHelper.getData(url: EndPoints.home, token: UserData.token);
    return HomeModel.fromJson(response: response);
  }


}
