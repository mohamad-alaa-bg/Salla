import 'package:dio/dio.dart';
import 'package:salla/features/categories/data/models/category_data.dart';

class CategoriesModel {
  final bool status;
  final List<CategoryData> categories;

  CategoriesModel({required this.status, required this.categories});

  factory CategoriesModel.fromJson(Response response) {
    List<Map<String, dynamic>> categoriesList = response.data['data']['data'];
    return CategoriesModel(
      status: response.data['status'],
      categories: categoriesList.map((e) => CategoryData.fromJson(e)).toList(),
    );
  }
}
