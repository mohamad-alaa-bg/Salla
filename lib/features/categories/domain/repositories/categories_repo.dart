import 'package:salla/features/categories/data/models/categories_model.dart';
import 'package:salla/features/categories/data/models/category_details.dart';

abstract class CategoriesRepo{
  Future<CategoriesModel> getCategories();
  Future<CategoryDetailsModel> getCategoryDetails({required int id});
}