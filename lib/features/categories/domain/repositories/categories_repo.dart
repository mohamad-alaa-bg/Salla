import 'package:salla/features/categories/data/models/categories_model.dart';

abstract class CategoriesRepo{
  Future<CategoriesModel> getCategories();
}