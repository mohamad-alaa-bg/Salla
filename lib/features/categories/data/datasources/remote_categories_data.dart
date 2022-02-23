import 'package:dio/dio.dart';
import 'package:salla/core/data/remote_data_source.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/features/categories/data/models/categories_model.dart';

abstract class RemoteCategoriesDataSource{
  Future<CategoriesModel> getCategories();
}

class RemoteCategoriesDataSourceImp extends RemoteCategoriesDataSource{
  @override
  Future<CategoriesModel> getCategories() async{
    Response response = await DioHelper.getData(url: EndPoints.categories);
    return CategoriesModel.fromJson(response);
  }

}