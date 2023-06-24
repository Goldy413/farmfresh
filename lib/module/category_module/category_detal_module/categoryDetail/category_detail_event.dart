part of 'category_detail_bloc.dart';

@immutable
abstract class CategoryDetailEvent {}

class CategoryStatusEvent extends CategoryDetailEvent {
  final bool isActive;
  CategoryStatusEvent(this.isActive);
}

class GetSubCategory extends CategoryDetailEvent {}

class GetCategoryProduct extends CategoryDetailEvent {}

class ChangeSubCategory extends CategoryDetailEvent {}

class GetSubCategoryProduct extends CategoryDetailEvent {
  final int index;
  GetSubCategoryProduct(this.index);
}

class DeleteSubCategoryProduct extends CategoryDetailEvent {
  final SubCategoryItem subCategoryItem;
  DeleteSubCategoryProduct(this.subCategoryItem);
}
