part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class ChangeCountryState extends LoginState {}

class ChangePhoneNumberState extends LoginState {}

class LogInLoadingState extends LoginState {}

class LogInErrorState extends LoginState {
  final String message;
  LogInErrorState(this.message);
}

class LoginedSuccesfullState extends LoginState {
  final String verifyId;
  final String phone;
  LoginedSuccesfullState(this.verifyId, this.phone);
}
