import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfresh/module/category_module/category_home_module/category_repository.dart';
import 'package:farmfresh/module/category_module/category_home_module/model/category.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  List<CategoryItem> categoryItem = <CategoryItem>[];
  CategoryRepository repo;
  bool gridSelected = true;
  CategoryBloc(this.repo) : super(CategoryInitial()) {
    on<ChangeCategory>((event, emit) {
      emit(CategorySuccesfully());
    });
    on<GridSelectedEvent>((event, emit) =>
        {gridSelected = event.isGridSelected, emit(GridSelectedState())});

    on<GetCategory>((event, emit) async => await repo.getCategory(
        categoryCallback: (category) => {
              categoryItem.clear(),
              for (DocumentSnapshot dataRef in category.docs)
                {
                  categoryItem.add(CategoryItem.fromJson(
                      dataRef.data() as Map<String, dynamic>)),
                  add(ChangeCategory())
                },
            }));
  }
}
