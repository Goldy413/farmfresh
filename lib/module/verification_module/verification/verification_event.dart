part of 'verification_bloc.dart';

@immutable
abstract class VerificationEvent {}

class VerificationTextChangeEvent extends VerificationEvent {
  final String otpValue;
  final String username;
  VerificationTextChangeEvent(this.otpValue, this.username);
}

class VerificationSubmitEvent extends VerificationEvent {
  final String phone;
  final String verificationCode;
  final String verifyId;
  VerificationSubmitEvent(this.phone, this.verificationCode, this.verifyId);
}

class ReSendPasswordEvent extends VerificationEvent {}

class VerificationErrorEvent extends VerificationEvent {
  final String msg;
  VerificationErrorEvent(this.msg);
}
