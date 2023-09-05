part of 'account_bloc.dart';

@immutable
abstract class AccountEvent {}

class SignOutEvent extends AccountEvent {}
