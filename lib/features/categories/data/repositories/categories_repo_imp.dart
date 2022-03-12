import 'package:salla/core/util/enum.dart';
import 'package:salla/features/categories/data/datasources/remote_categories_data.dart';
import 'package:salla/features/categories/data/models/categories_model.dart';
import 'package:salla/features/categories/data/models/category_details.dart';
import 'package:salla/features/categories/domain/repositories/categories_repo.dart';

class CategoriesRepoImp extends CategoriesRepo{
  CategoriesRepoImp(){
    print('create categories repo Imp') ;
  }
  RemoteCategoriesDataSourceImp remoteCategoriesDataSourceImp = RemoteCategoriesDataSourceImp();
  @override
  Future<CategoriesModel> getCategories(Language lang) async{
    return await remoteCategoriesDataSourceImp.getCategories(lang);
  }

  @override
  Future<CategoryDetailsModel> getCategoryDetails({required int id,required Language lang}) async{
    return await remoteCategoriesDataSourceImp.getCategoryDetails(id: id,lang: lang);
  }


}