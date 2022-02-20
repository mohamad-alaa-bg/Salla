import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:salla/features/home/data/models/home_data_model.dart';

class HomeModel extends Equatable{
  final bool status;
  final HomeDataModel data;

  const HomeModel({required this.status, required this.data});

  factory HomeModel.fromJson({required Response response}) {
    return HomeModel(
      status: response.data['status'],
      data: HomeDataModel.fromJson(data: response.data['data']),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status,data];
}
