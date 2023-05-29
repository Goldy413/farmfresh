import 'package:country_picker/country_picker.dart';
import 'package:farmfresh/module/login_module/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  String phone = "";
  final LoginRepository repo;
  LoginBloc(this.repo) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<ChangeCountryCodeEvent>((event, emit) =>
        {selectedCountry = event.country, emit(ChangeCountryState())});

    on<ChangePhoneNumber>(
        (event, emit) => {phone = event.phone, emit(ChangePhoneNumberState())});
    on<LoginSubmitEvent>((event, emit) async => await signInPhone(event, emit));
  }

  Future<void> signInPhone(
      LoginSubmitEvent event, Emitter<LoginState> emit) async {
    if (phone.isEmpty) {
      emit(LogInErrorState("Please enter phone number."));
    } else if (phone.length != 10) {
      emit(LogInErrorState("Please enter valid phone number."));
    } else {
      try {
        emit(LogInLoadingState());
        await repo
            .signinPhone("+${selectedCountry.phoneCode} $phone",
                callBack: (String verifyId) {}, emit: emit)
            .then((value) => {
                  emit(LoginedSuccesfullState(
                      value, "+${selectedCountry.phoneCode} $phone"))
                });
      } catch (err) {
        emit(LogInErrorState(err.toString()));
      }
    }
  }

  void moveToVerify(Emitter<LoginState> emit, String verifyId, String phone) {}
}
