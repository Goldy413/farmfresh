part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class ChangeCountryCodeEvent extends LoginEvent {
  final Country country;
  ChangeCountryCodeEvent(this.country);
}

class ChangePhoneNumber extends LoginEvent {
  final String phone;
  ChangePhoneNumber(this.phone);
}

class LoginSubmitEvent extends LoginEvent {}
