part of 'order_detail_bloc.dart';

@immutable
sealed class OrderDetailState {}

final class OrderDetailInitial extends OrderDetailState {}

final class ChangeStatusState extends OrderDetailState {}
