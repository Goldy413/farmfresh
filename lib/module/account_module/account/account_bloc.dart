import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfresh/utility/app_constants.dart';
import 'package:farmfresh/utility/app_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<AccountEvent>((event, emit) {});
    on<SignOutEvent>((event, emit) async {
      await FirebaseAuth.instance.signOut();
      await FirebaseFirestore.instance
          .collection(CollectionConstant.user)
          .doc(AppStorage().userDetail?.uid)
          .update({'fcmToken': ""}).then((value) => {});
      AppStorage().userDetail = null;
      AppStorage().token = null;
      emit(SignOutSucessfull());
    });
  }
}
