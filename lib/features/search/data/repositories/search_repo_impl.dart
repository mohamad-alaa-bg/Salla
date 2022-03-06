import 'package:salla/features/search/data/datasources/remote_search_source.dart';
import 'package:salla/features/search/data/models/search_model.dart';
import 'package:salla/features/search/domain/repositories/search_repo.dart';

class SearchRepoImpl implements SearchRepo{
  @override
  Future<SearchModel> search(String text) async{
    RemoteSearchSourceImp remoteSearchSourceImp = RemoteSearchSourceImp();
    return await remoteSearchSourceImp.search(text);
  }

}