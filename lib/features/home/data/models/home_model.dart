import 'package:dio/dio.dart';
import 'package:salla/features/home/data/models/home_data_model.dart';

class HomeModel {
  final String status;
  final HomeDataModel data;

  HomeModel({required this.status, required this.data});

  factory HomeModel.fromJson({required Response response}) {
    return HomeModel(
      status: response.data['status'],
      data: HomeDataModel.fromJson(data: response.data['data']),
    );
  }
}
