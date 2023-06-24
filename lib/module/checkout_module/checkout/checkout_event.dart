part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutEvent {}

class AddDeliveryAddressEvent extends CheckoutEvent {}

class GetAddressEvent extends CheckoutEvent {}

class ChangeStateEvent extends CheckoutEvent {}

class ChangeAddressEvent extends CheckoutEvent {
  final Address selectedAddress;
  ChangeAddressEvent(this.selectedAddress);
}
