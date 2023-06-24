part of 'product_detail_bloc.dart';

@immutable
abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class LoadingStatusState extends ProductDetailState {}

class ChangeState extends ProductDetailState {}

class ProductDetailErrorState extends ProductDetailState {
  final String message;
  ProductDetailErrorState(this.message);
}

class StateChangeState extends ProductDetailState {
  final ProductItem productItem;
  StateChangeState(this.productItem);
}

class ProductAddState extends ProductDetailState {
  final String name;
  final String qty;
  ProductAddState(this.name, this.qty);
}
