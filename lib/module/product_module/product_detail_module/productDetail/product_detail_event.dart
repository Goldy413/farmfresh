part of 'product_detail_bloc.dart';

@immutable
abstract class ProductDetailEvent {}

class GetProductDetailEvent extends ProductDetailEvent {}

class StateChangeEvent extends ProductDetailEvent {}

class SubtractQtyEvent extends ProductDetailEvent {}

class AddQtyEvent extends ProductDetailEvent {}

class SelectSizeEvent extends ProductDetailEvent {
  final ProductSize productSize;
  SelectSizeEvent(this.productSize);
}

class SelectColorEvent extends ProductDetailEvent {
  final ProductColor productColor;
  SelectColorEvent(this.productColor);
}

class GetBagEvent extends ProductDetailEvent {}

class AddtoBagEvent extends ProductDetailEvent {}

class GetSuggestedProductEvent extends ProductDetailEvent {}
