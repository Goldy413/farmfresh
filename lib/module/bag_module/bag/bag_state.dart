part of 'bag_bloc.dart';

@immutable
abstract class BagState {}

class BagInitial extends BagState {}

class ChangeState extends BagState {}

class ClearBagState extends BagState {}
