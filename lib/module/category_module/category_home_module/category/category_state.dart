part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategorySuccesfully extends CategoryState {}

class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}

class GridSelectedState extends CategoryState {}
