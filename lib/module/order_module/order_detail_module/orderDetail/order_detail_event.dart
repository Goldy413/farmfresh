part of 'order_detail_bloc.dart';

@immutable
sealed class OrderDetailEvent {}

class StatusChangedEvent extends OrderDetailEvent {
  final String status;
  StatusChangedEvent(this.status);
}
