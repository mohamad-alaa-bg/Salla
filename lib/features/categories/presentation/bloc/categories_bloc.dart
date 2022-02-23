import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla/features/categories/data/models/categories_model.dart';
import 'package:salla/features/categories/data/repositories/categories_repo_imp.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepoImp categoriesRepoImp;
  CategoriesBloc({required this.categoriesRepoImp}) : super(CategoriesInitial()) {
    on<CategoriesEvent>((event, emit) async{
      if(event is GetCategoriesEvent){
        emit(CategoriesIsLoadingState());
        try{
         categoriesData = await categoriesRepoImp.getCategories();
         emit(CategoriesSuccessState(categoriesModel: categoriesData));
        }catch(error){
          emit(CategoriesErrorState());
        }
      }
      // TODO: implement event handler
    });
  }

   CategoriesModel? categoriesData;
  static CategoriesBloc get(context) => BlocProvider.of(context);
}
