import 'package:farmfresh/module/login_module/model/login_model.dart';
import 'package:farmfresh/module/verification_module/verification_repository.dart';
import 'package:farmfresh/utility/app_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  var varificationCode = "";
  final VerificationRepository repo;
  VerificationBloc(this.repo) : super(VerificationInitial()) {
    on<VerificationErrorEvent>((event, emit) {
      emit(VerificationErrorState(event.msg));
    });
    on<VerificationTextChangeEvent>((event, emit) {
      varificationCode = event.otpValue;
      emit(VerificationValidState());
    });
    on<ReSendPasswordEvent>((event, emit) {
      emit(VerificationCodeResend());
    });

    on<VerificationSubmitEvent>((event, emit) async {
      if (varificationCode.length < 6) {
        emit(VerificationErrorState("Please Enter Valid OTP"));
      } else {
        try {
          emit(VerificationLoadingState());
          await repo.verifiOTP(
              verifyId: event.verifyId,
              otp: varificationCode,
              userCallBack: (UserModel userModel) => {
                    AppStorage().userDetail = userModel,
                    emit(MovetoHomeState())
                  },
              userNotExist: (String uid) =>
                  {emit(VerificationSuccesfullState(uid, event.phone))});
        } catch (err) {
          emit(VerificationErrorState(err.toString()));
        }
      }
    });
  }
}
