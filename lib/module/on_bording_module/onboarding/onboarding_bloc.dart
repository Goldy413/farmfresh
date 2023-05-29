import 'package:farmfresh/utility/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final pageController = PageController(initialPage: 0);
  int page = 0;
  final data = [
    {
      "title": "What is Lorem Ipsum",
      "image": ImageConstants.onboarding1SVG,
      "subtitle":
          "Lorem Ipsum is simply dummied text of the printing and typesetting industry. ",
    },
    {
      "title": "What is Lorem Ipsum",
      "image": ImageConstants.onboarding2SVG,
      "subtitle":
          "Lorem Ipsum is simply dummied text of the printing and typesetting industry. ",
    },
    {
      "title": "What is Lorem Ipsum",
      "image": ImageConstants.onboarding3SVG,
      "subtitle":
          "Lorem Ipsum is simply dummied text of the printing and typesetting industry. ",
    }
  ];
  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingEvent>((event, emit) {});
    on<PageChangeEvent>(
        (event, emit) => {page = event.value, emit(PageChangeState())});
  }

  Widget circleDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: isActive ? 8.w : 6.w,
      width: isActive ? 8.w : 6.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.green : Colors.grey.shade400,
      ),
    );
  }
}
