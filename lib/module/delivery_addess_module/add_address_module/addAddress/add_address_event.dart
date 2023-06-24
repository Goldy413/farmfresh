part of 'add_address_bloc.dart';

@immutable
abstract class AddAddressEvent {}

class ChangeTypeEvent extends AddAddressEvent {
  final String value;
  ChangeTypeEvent(this.value);
}

class SaveAddressEvent extends AddAddressEvent {}

class MoveBackEvent extends AddAddressEvent {}
