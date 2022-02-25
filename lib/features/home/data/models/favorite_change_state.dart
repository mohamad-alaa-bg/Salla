import 'package:dio/dio.dart';

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
