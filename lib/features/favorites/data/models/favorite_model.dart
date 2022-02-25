import 'package:dio/dio.dart';
import 'package:salla/features/favorites/data/models/favorites_data_products_model.dart';

class FavoritesModel {
  final bool status;
  final String message;
  final List<FavoritesProductsModel>? products;

  FavoritesModel({required this.status, required this.message, this.products});

  factory FavoritesModel.fromJson(Response response) {
    List<dynamic>? productsList = response.data['data']['data'];
    return FavoritesModel(
      status: response.data['status'],
      message: response.data['message']??'null',
      products: productsList?.map((e) => FavoritesProductsModel.fromJson(e))
              .toList(),
    );
  }
}
