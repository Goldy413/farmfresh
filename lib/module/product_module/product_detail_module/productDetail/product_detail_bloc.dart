import 'package:farmfresh/module/product_module/product_detail_module/model/product_model.dart';
import 'package:farmfresh/module/product_module/product_detail_module/product_detail_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductItem productItem;

  ProductDetailRepository repo;
  ProductDetailBloc(this.repo, this.productItem)
      : super(ProductDetailInitial()) {
    on<ProductDetailEvent>((event, emit) {});

    on<StateChangeEvent>((event, emit) => emit(StateChangeState(productItem)));
    on<GetProductDetailEvent>((event, emit) async => repo.getProductDetail(
        productItem.id, (product) => productItem = product));
  }
}
