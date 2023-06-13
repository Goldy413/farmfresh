part of 'category_detail_bloc.dart';

@immutable
abstract class CategoryDetailState {}

class CategoryDetailInitial extends CategoryDetailState {}

class CategoryDetailErrorState extends CategoryDetailState {
  final String message;
  CategoryDetailErrorState(this.message);
}

class ChangeStatusSuccesedState extends CategoryDetailState {}

class LoadingStatusState extends CategoryDetailState {}

class SubCategorySuccesfully extends CategoryDetailState {}
