import 'dart:async';

import 'package:farmfresh/module/login_module/login/login_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginRepository {
  Future<String> signinPhone(String phone,
      {required Function(String verifyId) callBack,
      required Emitter<LoginState> emit}) async {
    try {
      Completer<String> completer = Completer<String>();
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await FirebaseAuth.instance
                .signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            completer.complete(verificationId);
          },
          codeAutoRetrievalTimeout: (verificationId) {});

      return completer.future;
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    }
  }
}
