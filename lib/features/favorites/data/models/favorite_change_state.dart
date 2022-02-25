import 'package:dio/dio.dart';
import 'package:salla/features/favorites/data/models/favorites_data_products_model.dart';

class FavoriteStateModel {
  final bool status;
  final String message;

  FavoriteStateModel({required this.status, required this.message});

  factory FavoriteStateModel.fomJson(Response response) {
    return FavoriteStateModel(
      status: response.data['status'],
      message: response.data['message'],

    );
  }
}
