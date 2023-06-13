part of 'product_detail_bloc.dart';

@immutable
abstract class ProductDetailEvent {}

class GetProductDetailEvent extends ProductDetailEvent {}

class StateChangeEvent extends ProductDetailEvent {}
