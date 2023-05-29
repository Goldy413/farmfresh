import 'package:farmfresh/routes.dart';
import 'package:farmfresh/utility/app_constants.dart';
import 'package:farmfresh/utility/app_storage.dart';
import 'package:farmfresh/utility/custom_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'splash/splash_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<SplashBloc, SplashState>(
        bloc: SplashBloc(),
        builder: (context, state) {
          return Stack(
            children: [
              Positioned(
                  bottom: 20,
                  right: 20,
                  left: 20,
                  child: SizedBox(
                    width: 1.sw,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomMaterialButton(
                          onPressed: () =>
                              context.go(AppStorage().isOnBoardingShowed()
                                  ? AppStorage().isLoggedIn()
                                      ? AppPaths.tabbar
                                      : AppPaths.login
                                  : AppPaths.onbording),
                          buttonText: "Get Start",
                        )),
                  )),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      ImageConstants.logo,
                      // width: 0.5.sw,
                      // height: 0.5.sh,
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
