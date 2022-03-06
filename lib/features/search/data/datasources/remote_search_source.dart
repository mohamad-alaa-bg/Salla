import 'package:dio/dio.dart';
import 'package:salla/core/data/remote_data_source.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/features/search/data/models/search_model.dart';

abstract class RemoteSearchSource {
  Future<SearchModel> search(String text);
}

class RemoteSearchSourceImp implements RemoteSearchSource {
  @override
  Future<SearchModel> search(String text) async {
    Response response = await DioHelper.postData(
      url: EndPoints.search,
      data: {"text": text},
    );
    return SearchModel.fromJson(response);
  }
}
