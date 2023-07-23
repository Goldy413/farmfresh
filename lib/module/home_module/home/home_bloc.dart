import 'dart:async';

import 'package:farmfresh/module/home_module/home_repository.dart';
import 'package:farmfresh/module/home_module/model/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository repo;
  List<Ban> banner = [];
  var pageController = PageController();
  int current = 0;
  late Timer timer;
  HomeBloc(this.repo) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<GetBannerEvent>((event, emit) =>
        repo.getBanner(callback: (BannerModel bannerModelValue) {
          banner = bannerModelValue.banner;
          add(GetPaggerEvent());
        }));

    on<GetPaggerEvent>((event, emit) => emit(ChangeState()));
  }
  void autoPlayBanner(List<Ban> banner) {
    timer = Timer.periodic(const Duration(seconds: 5), (callback) {
      if (banner.length == 1) {
        timer.cancel();
      } else if (banner.length > 1) {
        if (current >= banner.length && pageController.hasClients) {
          pageController.animateToPage(0,
              duration: const Duration(seconds: 2), curve: Curves.linear);
        } else {
          if (pageController.hasClients) {
            pageController.animateToPage(current++,
                duration: const Duration(seconds: 2), curve: Curves.linear);
          }
        }
      }
    });
  }

  onPageChange(int index) {
    current = index;
  }
}
