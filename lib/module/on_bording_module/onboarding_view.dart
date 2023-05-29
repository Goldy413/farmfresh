import 'dart:math';
import 'package:farmfresh/module/on_bording_module/onboarding/onboarding_bloc.dart';
import 'package:farmfresh/routes.dart';
import 'package:farmfresh/utility/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => OnboardingBloc(),
          child: BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              var bloc = context.read<OnboardingBloc>();
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Farm Fresh",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 24.sp),
                        ),
                        TextButton(
                            onPressed: () {
                              AppStorage().onBoardingShowed(true);
                              context.go(AppStorage().isLoggedIn()
                                  ? AppPaths.tabbar
                                  : AppPaths.login);
                            },
                            child: Text("Skip",
                                style: TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp)))
                      ],
                    ),
                  ),
                  Expanded(
                      child: PageView.builder(
                          controller: bloc.pageController,
                          physics: const ClampingScrollPhysics(),
                          itemCount: bloc.data.length,
                          itemBuilder: (context, index) {
                            final content = bloc.data[index];
                            return SvgPicture.asset(content['image'] ?? '');
                          },
                          onPageChanged: (value) =>
                              bloc.add(PageChangeEvent(value)))),
                  Container(
                    margin: EdgeInsets.all(25.w),
                    padding:
                        EdgeInsets.symmetric(vertical: 40.h, horizontal: 25.w),
                    height: 263.h,
                    decoration: BoxDecoration(
                        color: const Color(0xffF7F7F7),
                        borderRadius: BorderRadius.circular(40.w)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(bloc.data[bloc.page]["title"] ?? "",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.montserrat(
                                color: Colors.green,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w800)),
                        SizedBox(height: 14.h),
                        Text(
                          bloc.data[bloc.page]["subtitle"] ?? "",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff181920)),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                    bloc.data.length,
                                    (index) =>
                                        bloc.circleDot(index == bloc.page))),
                            InkWell(
                              onTap: () {
                                if (bloc.page == bloc.data.length - 1) {
                                  AppStorage().onBoardingShowed(true);
                                  context.go(AppStorage().isLoggedIn()
                                      ? AppPaths.tabbar
                                      : AppPaths.login);

                                  return;
                                }
                                bloc.add(PageChangeEvent(
                                    min(bloc.page + 1, bloc.data.length - 1)));
                                bloc.pageController.animateToPage(bloc.page,
                                    duration: const Duration(milliseconds: 150),
                                    curve: Curves.decelerate);
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 20.w,
                                    backgroundColor: Colors.green,
                                    child: Icon(
                                      (bloc.page == (bloc.data.length - 1))
                                          ? Icons.check
                                          : Icons.arrow_forward_ios,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50.w,
                                    height: 50.w,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 4,
                                        backgroundColor: Colors.grey.shade200,
                                        color: Colors.green,
                                        value:
                                            (bloc.page + 1) / bloc.data.length),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
