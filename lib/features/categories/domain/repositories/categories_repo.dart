import 'package:salla/core/util/enum.dart';
import 'package:salla/features/categories/data/models/categories_model.dart';
import 'package:salla/features/categories/data/models/category_details.dart';

abstract class CategoriesRepo{
  Future<CategoriesModel> getCategories(Language lang);
  Future<CategoryDetailsModel> getCategoryDetails({required int id});
}