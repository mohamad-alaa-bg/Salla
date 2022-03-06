import 'package:salla/features/search/data/models/search_model.dart';

abstract class SearchRepo{
  Future<SearchModel> search(String text);
}