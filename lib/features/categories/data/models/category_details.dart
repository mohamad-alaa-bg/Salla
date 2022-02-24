import 'package:dio/dio.dart';
import 'package:salla/features/home/data/models/product_model.dart';

class CategoryDetailsModel {
  final bool status;
  final List<ProductModel> products;

  CategoryDetailsModel({required this.status, required this.products});

  factory CategoryDetailsModel.fromJson(Response response) {
    List<dynamic> productsList = response.data['data']['data'];
    return CategoryDetailsModel(
        status: response.data['status'],
        products: productsList
            .map((e) => ProductModel.fromJson(product: e))
            .toList());
  }
}
