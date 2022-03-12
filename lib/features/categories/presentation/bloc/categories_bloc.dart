import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla/features/categories/data/models/category_details.dart';
import 'package:salla/features/categories/data/models/categories_model.dart';
import 'package:salla/features/categories/domain/repositories/categories_repo.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepo categoriesRepo;
  CategoriesBloc({required this.categoriesRepo}) : super(CategoriesInitial()) {
    print('create categories bloc');
    on<CategoriesEvent>((event, emit) async{
      if(event is GetCategoriesEvent){
        emit(CategoriesIsLoadingState());
        try{
         categoriesData = await categoriesRepo.getCategories();
         emit(CategoriesSuccessState(categoriesModel: categoriesData));
        }catch(error){
          emit(CategoriesErrorState());
        }
      }else if(event is GetCategoryDetailsEvent){
        emit(CategoryDetailsIsLoadingState());
        try{
          categoryDetails = await categoriesRepo.getCategoryDetails(id: event.id);
          print(categoryDetails!.products.length);
          emit(CategoryDetailsSuccessState(categoryDetails: categoryDetails));
        }catch(error){
          print(error);
          emit(CategoryDetailsErrorState());
        }
      }

      // TODO: implement event handler
    });
  }

   CategoriesModel? categoriesData;
   CategoryDetailsModel? categoryDetails;
  static CategoriesBloc get(context) => BlocProvider.of(context);
}
