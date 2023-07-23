part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetBannerEvent extends HomeEvent {}

class GetPaggerEvent extends HomeEvent {}
