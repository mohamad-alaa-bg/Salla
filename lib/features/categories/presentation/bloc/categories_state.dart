part of 'categories_bloc.dart';

@immutable
abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesIsLoadingState extends CategoriesState {}

class CategoriesSuccessState extends CategoriesState {
  final CategoriesModel categoriesModel;

  CategoriesSuccessState({required this.categoriesModel});
}

class CategoriesErrorState extends CategoriesState {}
