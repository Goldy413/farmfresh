part of 'verification_bloc.dart';

@immutable
abstract class VerificationState {}

class VerificationInitial extends VerificationState {}

class VerificationErrorState extends VerificationState {
  final String errorMessage;
  VerificationErrorState(this.errorMessage);
}

class VerificationSuccesfullState extends VerificationState {
  final String uid;
  final String phone;
  VerificationSuccesfullState(this.uid, this.phone);
}

class MovetoHomeState extends VerificationState {
  MovetoHomeState();
}

class VerificationValidState extends VerificationState {}

class VerificationCodeResend extends VerificationState {}

class VerificationLoadingState extends VerificationState {}
