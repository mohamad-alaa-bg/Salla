part of 'categories_bloc.dart';

@immutable
abstract class CategoriesEvent {}

class GetCategoriesEvent extends CategoriesEvent {}

class GetCategoryDetailsEvent extends CategoriesEvent {
  final int id;

  GetCategoryDetailsEvent({required this.id});
}
