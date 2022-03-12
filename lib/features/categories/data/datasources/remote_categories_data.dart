import 'package:dio/dio.dart';
import 'package:salla/core/data/remote_data_source.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/core/util/enum.dart';
import 'package:salla/features/categories/data/models/categories_model.dart';
import 'package:salla/features/categories/data/models/category_details.dart';

abstract class RemoteCategoriesDataSource {
  Future<CategoriesModel> getCategories(Language lang);

  Future<CategoryDetailsModel> getCategoryDetails({required int id});
}

class RemoteCategoriesDataSourceImp extends RemoteCategoriesDataSource {
  RemoteCategoriesDataSourceImp() {
    print('create categories data Imp');
  }

  @override
  Future<CategoriesModel> getCategories(Language lang) async {
    Response response = await DioHelper.getData(
        url: EndPoints.categories,
        lang: lang == Language.english ? 'en' : 'ar');
    return CategoriesModel.fromJson(response);
  }

  @override
  Future<CategoryDetailsModel> getCategoryDetails({required int id}) async {
    String url = EndPoints.categories + '/$id';
    Response response = await DioHelper.getData(url: url);
    return CategoryDetailsModel.fromJson(response);
  }
}
