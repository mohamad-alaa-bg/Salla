import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla/features/search/data/models/search_model.dart';
import 'package:salla/features/search/data/repositories/search_repo_impl.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepoImpl searchRepoImpl;

  SearchBloc({required this.searchRepoImpl}) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      if (event is SearchProductsEvent) {
        try {
          emit(SearchIsLoadingState());
          SearchModel searchModel = await searchRepoImpl.search(event.text);
          print(searchModel.status);
          if (searchModel.status) {
            emit(SearchLoadedSuccessState(searchProduct: searchModel));
          } else {
            emit(SearchErrorState());
          }
        } catch (error) {
          print(error);
          emit(SearchErrorState());
        }
      }
      // TODO: implement event handler
    });
  }

  static SearchBloc get(context) => BlocProvider.of(context);
}
