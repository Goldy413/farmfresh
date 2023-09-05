import 'dart:async';

import 'package:farmfresh/module/home_module/home_repository.dart';
import 'package:farmfresh/module/home_module/model/banner_model.dart';
import 'package:farmfresh/module/home_module/model/review_model.dart';
import 'package:farmfresh/module/product_module/product_detail_module/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ScrollController controller = ScrollController();
  HomeRepository repo;
  List<Ban> banner = [];
  List<ProductItem> productItem = [];
  List<ProductItem> mostOrderproductItem = [];
  List<ReviewModel> reviewList = [];
  var pageController = PageController();
  int current = 0;
  late Timer timer;
  HomeBloc(this.repo) : super(HomeInitial()) {
    controller.addListener(_scrollListener);
    on<HomeEvent>((event, emit) {});
    on<GetMostOrderProductEvent>((event, emit) async => await repo.getMostOrder(
          callback: (List<ProductItem> productItem) =>
              {mostOrderproductItem = productItem, add(GetPaggerEvent())},
        ));
    on<GetProductEvent>((event, emit) async => await repo.getFirstList(
          callback: (List<ProductItem> productItem) =>
              {this.productItem = productItem, add(GetPaggerEvent())},
        ));

    on<GetNextProductEvent>((event, emit) async => await repo.fetchNextProduct(
          productItem,
          callback: (List<ProductItem> productItem) =>
              {this.productItem.addAll(productItem), add(GetPaggerEvent())},
        ));

    on<GetBannerEvent>((event, emit) async =>
        await repo.getBanner(callback: (BannerModel bannerModelValue) {
          List<Ban> bannerList = [];
          for (var element in bannerModelValue.banner) {
            if (element.isActive) {
              bannerList.add(element);
            }
          }

          banner = bannerList;
          add(GetPaggerEvent());
        }));

    on<GetReviewEvent>((event, emit) async {
      await repo.getReview(callback: (List<ReviewModel> reviewList) {
        this.reviewList = reviewList;
        add(GetPaggerEvent());
      });
    });
    on<GetPaggerEvent>((event, emit) => emit(ChangeState()));
  }

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      add(GetNextProductEvent());
    }
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
