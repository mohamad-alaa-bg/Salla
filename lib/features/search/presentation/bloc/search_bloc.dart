import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla/features/search/data/models/search_model.dart';
import 'package:salla/features/search/domain/repositories/search_repo.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepo searchRepo;

  SearchBloc({required this.searchRepo}) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      if (event is SearchProductsEvent) {
        try {
          emit(SearchIsLoadingState());
          SearchModel searchModel = await searchRepo.search(event.text);
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
