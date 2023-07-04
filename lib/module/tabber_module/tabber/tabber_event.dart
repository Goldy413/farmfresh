part of 'tabber_bloc.dart';

@immutable
abstract class TabberEvent {}

class ChangeTabEvent extends TabberEvent {
  final int index;
  ChangeTabEvent(this.index);
}

class SubscribeBrodcast extends TabberEvent {}
