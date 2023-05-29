import 'package:country_picker/country_picker.dart';
import 'package:farmfresh/module/login_module/login/login_bloc.dart';
import 'package:farmfresh/module/login_module/login_repository.dart';
import 'package:farmfresh/routes.dart';
import 'package:farmfresh/utility/app_constants.dart';
import 'package:farmfresh/utility/extensions.dart';
import 'package:farmfresh/utility/ui/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      const Background(false),
      Align(
        alignment: Alignment.center,
        child: Container(
          width: 0.9.sw >= 0.9.sh ? 0.9.sh : 0.9.sw,
          padding: const EdgeInsets.all(6),
          child: RepositoryProvider(
            create: (context) => LoginRepository(),
            child: BlocProvider(
              create: (context) => LoginBloc(context.read()),
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  var bloc = context.read<LoginBloc>();
                  return Column(mainAxisSize: MainAxisSize.min, children: [
                    Image.asset(
                      ImageConstants.logo,
                      width: 0.3.sw >= 0.3.sh ? 0.3.sh : 0.3.sw,
                    ),
                    state is LogInErrorState
                        ? Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          )
                        : const SizedBox(),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.deny(" ")
                      ],
                      onChanged: (phone) => bloc.add(ChangePhoneNumber(phone)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(74, 158, 158, 158),
                        hintText: "Phone Number",
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 8),
                          child: InkWell(
                            onTap: () {
                              showCountryPicker(
                                  context: context,
                                  countryListTheme: const CountryListThemeData(
                                    bottomSheetHeight: 550,
                                  ),
                                  onSelect: (value) {
                                    bloc.add(ChangeCountryCodeEvent(value));
                                  });
                            },
                            child: Text(
                              "${bloc.selectedCountry.flagEmoji} + ${bloc.selectedCountry.phoneCode}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        suffixIcon: bloc.phone.length == 10
                            ? Container(
                                height: 30,
                                width: 30,
                                margin: const EdgeInsets.all(10.0),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                ),
                                child: const Icon(
                                  Icons.done,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: BlocListener<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state is LoginedSuccesfullState) {
                            context.goNamed(AppPaths.passVerification, params: {
                              'phone': state.phone,
                              'verifyId': state.verifyId
                            });
                          }
                        },
                        child: MaterialButton(
                          onPressed: () {
                            if (state is! LogInLoadingState) {
                              context.hideKeyboard();
                              bloc.add(LoginSubmitEvent());
                            }
                          },
                          color: Colors.green,
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(16),
                          shape: const CircleBorder(),
                          child: Icon(
                            state is LogInLoadingState
                                ? Icons.back_hand_outlined
                                : Icons.arrow_forward_outlined,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ]);
                },
              ),
            ),
          ),
        ),
      )
    ]));
  }
}
