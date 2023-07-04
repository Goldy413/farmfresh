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

class ChangePaymentMethodEvent extends CheckoutEvent {
  final PaymentMethod selectedPaymentMethod;
  ChangePaymentMethodEvent(this.selectedPaymentMethod);
}

class GetPaymentMethodEvent extends CheckoutEvent {}

class GetDeliveryAreaEvent extends CheckoutEvent {}

class AddDelievryCharge extends CheckoutEvent {
  final Address selectedAddress;
  AddDelievryCharge(this.selectedAddress);
}

class OnPlaceOrderEvent extends CheckoutEvent {}

class DeleteBagEvent extends CheckoutEvent {}
