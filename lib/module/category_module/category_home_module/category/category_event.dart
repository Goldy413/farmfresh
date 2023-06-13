part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class ChangeCategory extends CategoryEvent {}

class GridSelectedEvent extends CategoryEvent {
  final bool isGridSelected;
  GridSelectedEvent(this.isGridSelected);
}

class GetCategory extends CategoryEvent {}
