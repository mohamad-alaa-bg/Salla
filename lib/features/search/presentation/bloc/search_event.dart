part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchProductsEvent extends SearchEvent {
  final String text;

  SearchProductsEvent({required this.text});
}
