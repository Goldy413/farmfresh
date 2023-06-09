part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class AddAddressState extends CheckoutState {
  final Position userLocation;
  AddAddressState(this.userLocation);
}

class AddAddressLoadingState extends CheckoutState {}

class ChangeState extends CheckoutState {}

class OrderPlacedSucessfully extends CheckoutState {}

class CheckoutErrorState extends CheckoutState {
  final String message;
  CheckoutErrorState(this.message);
}
