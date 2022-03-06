part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}
class SearchIsLoadingState extends SearchState {}
class SearchLoadedSuccessState extends SearchState {}
class SearchErrorState extends SearchState {}
