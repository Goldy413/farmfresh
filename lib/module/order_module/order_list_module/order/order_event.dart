part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class GetOrderEvent extends OrderEvent {}

class ChangeOrder extends OrderEvent {}
