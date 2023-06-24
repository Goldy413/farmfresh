part of 'bag_bloc.dart';

@immutable
abstract class BagEvent {}

class GetBagEvent extends BagEvent {}

class ChangeStateEvent extends BagEvent {}

class ClearCartEvent extends BagEvent {}

class RemoveItemsEvent extends BagEvent {
  final int index;
  RemoveItemsEvent(this.index);
}
