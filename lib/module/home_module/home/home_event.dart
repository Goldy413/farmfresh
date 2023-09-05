part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetBannerEvent extends HomeEvent {}

class GetPaggerEvent extends HomeEvent {}

class GetReviewEvent extends HomeEvent {}

class GetProductEvent extends HomeEvent {}

class GetNextProductEvent extends HomeEvent {}

class GetMostOrderProductEvent extends HomeEvent {}
