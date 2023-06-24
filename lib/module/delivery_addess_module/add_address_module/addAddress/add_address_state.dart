part of 'add_address_bloc.dart';

@immutable
abstract class AddAddressState {}

class AddAddressInitial extends AddAddressState {}

class ChangeTypeState extends AddAddressState {}

class AddAddressErrorState extends AddAddressState {
  final String message;
  AddAddressErrorState(this.message);
}

class MoveBackState extends AddAddressState {}

class AddAddressLoading extends AddAddressState {}
