part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class SelectImageEvent extends HomeEvent {
  final XFile? file;
  SelectImageEvent(this.file);
}

class CompressImageEvent extends HomeEvent {}
