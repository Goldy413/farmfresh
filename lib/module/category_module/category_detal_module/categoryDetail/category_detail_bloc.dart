import 'package:farmfresh/module/category_module/category_detal_module/category_detail_repository.dart';
import 'package:farmfresh/module/category_module/category_home_module/model/category.dart';
import 'package:farmfresh/module/category_module/category_home_module/model/sub_category_model.dart';
import 'package:farmfresh/module/product_module/product_detail_module/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'category_detail_event.dart';
part 'category_detail_state.dart';

class CategoryDetailBloc
    extends Bloc<CategoryDetailEvent, CategoryDetailState> {
  final CategoryItem category;
  final CategoryDetailRepository repo;
  List<SubCategoryItem> subCategoryItem = <SubCategoryItem>[];
  List<ProductItem> independentProductItem = [];
  CategoryDetailBloc(this.category, this.repo)
      : super(CategoryDetailInitial()) {
    on<CategoryDetailEvent>((event, emit) {});
    on<ChangeSubCategory>((event, emit) {
      emit(SubCategorySuccesfully());
    });
    on<DeleteSubCategoryProduct>((event, emit) async {
      await repo.deleteSubCategory(subCategoryItem: event.subCategoryItem);
    });

    on<CategoryStatusEvent>((event, emit) async {
      try {
        emit(LoadingStatusState());
        category.isActive = event.isActive;
        await repo.changeStatus(categoryItem: category);
        emit(ChangeStatusSuccesedState());
      } catch (err) {
        emit(CategoryDetailErrorState(err.toString()));
      }
    });

    on<GetSubCategoryProduct>((event, emit) async =>
        await repo.getSubCategoryProduct(
            productCallback: (List<ProductItem> productItem) => {
                  subCategoryItem[event.index].productItem = productItem,
                  add(ChangeSubCategory())
                },
            subCategory: subCategoryItem[event.index]));

    on<GetSubCategory>((event, emit) => repo.getSubCategory(
        category: category,
        categoryCallback: (subCategoryList) => {
              subCategoryItem = subCategoryList,
              // emit(SubCategorySuccesfully())
              add(ChangeSubCategory())
            }));

    on<GetCategoryProduct>((event, emit) async => await repo.getCategoryProduct(
        productCallback: (List<ProductItem> productItem) =>
            {independentProductItem = productItem, add(ChangeSubCategory())},
        category: category));
  }
}
