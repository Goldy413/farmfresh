import 'package:farmfresh/module/verification_module/verification/verification_bloc.dart';
import 'package:farmfresh/module/verification_module/verification_repository.dart';
import 'package:farmfresh/routes.dart';
import 'package:farmfresh/utility/ui/background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/style.dart';

class VerificationView extends StatelessWidget {
  final String phone;
  final String verifyId;
  const VerificationView(
      {super.key, required this.phone, required this.verifyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(
          children: [
            const Background(true),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.all(6),
                child: RepositoryProvider(
                  create: (context) => VerificationRepository(),
                  child: BlocProvider(
                    create: (context) => VerificationBloc(context.read()),
                    // ..add(VerificationErrorEvent(msg)),
                    child: BlocBuilder<VerificationBloc, VerificationState>(
                      builder: (context, state) {
                        var bloc = context.read<VerificationBloc>();
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisSize: MainAxisSize.max,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Please enter the 6 digits code sent\nto $phone",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              state is VerificationErrorState
                                  ? Text(
                                      state.errorMessage,
                                      style: const TextStyle(color: Colors.red),
                                    )
                                  : const SizedBox(),
                              const SizedBox(height: 10),
                              const SizedBox(height: 10),
                              OTPTextField(
                                length: 6,
                                width: MediaQuery.of(context).size.width,
                                textFieldAlignment:
                                    MainAxisAlignment.spaceAround,
                                fieldWidth: 45,
                                fieldStyle: FieldStyle.underline,
                                outlineBorderRadius: 15,
                                style: const TextStyle(fontSize: 17),
                                onChanged: (String code) {
                                  bloc.add(
                                      VerificationTextChangeEvent(code, phone));
                                },
                                //runs when every textfield is filled
                                onCompleted: (String verificationCode) {
                                  bloc.add(VerificationTextChangeEvent(
                                      verificationCode, phone));
                                },
                              ),
                              const SizedBox(height: 20),
                              BlocConsumer<VerificationBloc, VerificationState>(
                                listener: (context, state) {
                                  if (state is VerificationCodeResend) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      backgroundColor: Colors.amber,
                                      content: Text(
                                        'Your Verification code has re-sent your registerd e-mail.',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      duration: Duration(seconds: 2),
                                    ));
                                  }
                                },
                                builder: (context, state) {
                                  return InkWell(
                                    onTap: () =>
                                        {bloc.add(ReSendPasswordEvent())},
                                    child: Text(
                                      "Resend OTP",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: BlocConsumer<VerificationBloc,
                                    VerificationState>(
                                  listener: (context, state) {
                                    if (state is VerificationSuccesfullState) {
                                      context.pushReplacementNamed(
                                          AppPaths.profile,
                                          params: {
                                            'phone': state.phone,
                                            'id': state.uid
                                          });
                                      // context.go(AppPaths.profile);
                                    } else if (state is MovetoHomeState) {
                                      context.go(AppPaths.tabbar);
                                    }
                                  },
                                  builder: (context, state) {
                                    return SizedBox(
                                      width: 1.sw,
                                      child: Padding(
                                        padding: const EdgeInsets.all(30),
                                        child: MaterialButton(
                                          onPressed: () {
                                            bloc.add(VerificationSubmitEvent(
                                              phone,
                                              bloc.varificationCode,
                                              verifyId,
                                            ));
                                          },
                                          elevation: 2,
                                          color: const Color(0xFF1B5E20),
                                          splashColor:
                                              Colors.grey.withOpacity(0.5),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 25),
                                          shape:
                                              //CircleBorder(),

                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                          ),
                                          child: Text(
                                            state is VerificationLoadingState
                                                ? "Loading..."
                                                : "Verify OTP",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ]);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
