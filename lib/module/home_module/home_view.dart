import 'package:farmfresh/module/home_module/home/home_bloc.dart';
import 'package:farmfresh/module/home_module/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeView extends StatelessWidget {
  final picker = ImagePicker();
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: RepositoryProvider(
        create: (context) => HomeRepository(),
        child: BlocProvider(
          create: (context) => HomeBloc(context.read())..add(GetBannerEvent()),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              var bloc = context.read<HomeBloc>();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 202.h,
                        child: BlocConsumer<HomeBloc, HomeState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            List<Widget> pages = getPage(context, bloc);
                            return pages.isNotEmpty
                                ? Column(
                                    children: [
                                      Expanded(
                                        child: PageView(
                                            allowImplicitScrolling: true,
                                            controller: bloc.pageController,
                                            scrollDirection: Axis.horizontal,
                                            onPageChanged: (index) => {
                                                  bloc.onPageChange(index),
                                                },
                                            children: pages),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SmoothPageIndicator(
                                        controller: bloc.pageController,
                                        count: pages.length,
                                        effect: const WormEffect(
                                          dotHeight: 16,
                                          dotWidth: 16,
                                          type: WormType.thinUnderground,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  )
                                : const SizedBox();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> getPage(BuildContext context, HomeBloc bloc) {
    final pagerList = <Widget>[];
    //List<Ban> banner = bloc.banner;
    for (int i = 0; i < bloc.banner.length; i++) {
      pagerList.add(GestureDetector(
        onTap: () => {
          // Get.to(() => new ProductsScreen(
          //     categoryId: bannerItems[i].id,
          //     products: [],
          //     title: bannerItems[i].name))
        },
        child: ClipRRect(
          child: Image.network(bloc.banner[i].image,
              width: 1.sw, fit: BoxFit.fill),
        ),
      ));
    }
    bloc.autoPlayBanner(bloc.banner);
    return pagerList;
  }
}
