import 'package:dio/dio.dart';
import 'package:salla/features/home/data/models/product_model.dart';

class SearchModel {
  final bool status;
  final List<ProductModel> products;

  SearchModel({required this.status, required this.products});

  factory SearchModel.fromJson(Response response) {
    List<dynamic> productsList = response.data['data']['data'];
    return SearchModel(
        status: response.data['status'],
        products: productsList
            .map((e) => ProductModel.fromJson(product: e))
            .toList());
  }
}
