part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingEvent {}

class PageChangeEvent extends OnboardingEvent {
  final int value;
  PageChangeEvent(this.value);
}
