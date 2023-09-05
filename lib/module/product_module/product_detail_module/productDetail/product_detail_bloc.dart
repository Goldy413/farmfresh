import 'dart:math';

import 'package:farmfresh/module/bag_module/model/bag_model.dart';
import 'package:farmfresh/module/product_module/product_detail_module/model/product_model.dart';
import 'package:farmfresh/module/product_module/product_detail_module/product_detail_repository.dart';
import 'package:farmfresh/utility/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductItem productItem;
  final TextEditingController textController = TextEditingController(text: "1");
  ProductDetailRepository repo;
  int qty = 1;
  String color = "";
  String size = "";
  double price = 0.0;
  late BagModel bagModel;
  List<ProductItem> suggestedProductItem = [];

  ProductDetailBloc(this.repo, this.productItem)
      : super(ProductDetailInitial()) {
    var userDetail = AppStorage().userDetail!;
    bagModel = AppStorage().userBag ??
        BagModel(
            id: "",
            userId: userDetail.uid,
            userName: userDetail.name,
            items: []);
    price = productItem.discountPrice;
    size = productItem.varient.size.isNotEmpty
        ? productItem.varient.size[0].name
        : "";

    color = productItem.varient.color.isNotEmpty
        ? productItem.varient.color[0].name
        : "";
    bagModel.deliveryCharge = 20.00;
    textController.text = qty.toString();
    on<ProductDetailEvent>((event, emit) {});

    on<SubtractQtyEvent>((event, emit) =>
        {qty--, qty = max(qty, 1), textController.text = qty.toString()});
    on<AddQtyEvent>((event, emit) =>
        {qty++, qty = max(qty, 1), textController.text = qty.toString()});

    on<SelectSizeEvent>((event, emit) => {
          size = event.productSize.name,
          price =
              event.productSize.price, // max(price, event.productSize.price),
          emit(ChangeState())
        });
    on<SelectColorEvent>((event, emit) => {
          color = event.productColor.name,
          price = event.productColor.price,
          emit(ChangeState())
        });

    on<StateChangeEvent>((event, emit) => emit(StateChangeState(productItem)));
    on<GetProductDetailEvent>((event, emit) async => await repo
        .getProductDetail(productItem.id, (product) => productItem = product));

    on<GetBagEvent>((event, emit) async {
      await repo.getBag();
    });
    on<GetSuggestedProductEvent>(
        (event, emit) async => await repo.getSuggestedProduct(
              callback: (List<ProductItem> productItem) =>
                  {suggestedProductItem = productItem, add(StateChangeEvent())},
            ));

    on<AddtoBagEvent>((event, emit) async {
      bagModel.items.add(CartItems(
        color: color,
        image: productItem.image,
        name: productItem.name,
        price: price,
        productId: productItem.id,
        qty: qty,
        size: size,
      ));

      await repo.addBag(bagModel: bagModel);
      emit(ProductAddState(productItem.name, qty.toString()));
    });
  }
}
