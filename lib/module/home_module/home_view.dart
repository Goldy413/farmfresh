import 'package:farmfresh/module/home_module/home/home_bloc.dart';
import 'package:farmfresh/module/home_module/home_repository.dart';
import 'package:farmfresh/module/product_module/product_detail_module/model/product_model.dart';
import 'package:farmfresh/routes.dart';
import 'package:farmfresh/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

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
          create: (context) => HomeBloc(context.read())
            ..add(GetMostOrderProductEvent())
            ..add(GetProductEvent())
            ..add(GetReviewEvent())
            ..add(GetBannerEvent()),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              var bloc = context.read<HomeBloc>();
              List<Widget> pages = getPage(context, bloc);
              return Padding(
                padding: const EdgeInsets.all(0.0),
                child: SingleChildScrollView(
                  controller: bloc.controller,
                  child: Column(
                    children: [
                      pages.isNotEmpty
                          ? SizedBox(
                              height: 202.h,
                              child: Stack(
                                children: [
                                  PageView(
                                      allowImplicitScrolling: true,
                                      controller: bloc.pageController,
                                      scrollDirection: Axis.horizontal,
                                      onPageChanged: (index) => {
                                            bloc.onPageChange(index),
                                          },
                                      children: pages),
                                  Positioned(
                                      bottom: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        width: 1.sw,
                                        child: Center(
                                          child: SmoothPageIndicator(
                                            controller: bloc.pageController,
                                            count: pages.length,
                                            effect: const WormEffect(
                                                dotHeight: 16,
                                                dotWidth: 16,
                                                type: WormType.thinUnderground,
                                                dotColor: Colors.black,
                                                activeDotColor: Colors.green),
                                          ),
                                        ),
                                      )),
                                ],
                              ))
                          : const SizedBox(),
                      bloc.mostOrderproductItem.isNotEmpty
                          ? SizedBox(
                              height: 0.3.sh,
                              child: Column(
                                children: [
                                  Container(
                                      width: 1.sw,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Theme.of(context)
                                                .colorScheme
                                                .onPrimary
                                                .withOpacity(0.7),
                                            Theme.of(context)
                                                .colorScheme
                                                .onPrimary
                                                .withOpacity(0.3),
                                            const Color(0xFFFEC8D1),
                                            const Color(0xFFFEC8D1),
                                            Colors.white,
                                          ],
                                        ),
                                      ),
                                      child: Text(
                                        "Most Order Items",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                      )),
                                  Expanded(
                                    child: ListView.separated(
                                        padding: const EdgeInsets.all(8),
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            bloc.mostOrderproductItem.length,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(width: 15),
                                        itemBuilder: (context, index) {
                                          return productItem(
                                              bloc.mostOrderproductItem[index],
                                              context);
                                        }),
                                  )
                                ],
                              ),
                            )
                          : const SizedBox(),
                      bloc.reviewList.isNotEmpty
                          ? SizedBox(
                              height: 400,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Theme.of(context)
                                                .colorScheme
                                                .onPrimary
                                                .withOpacity(0.7),
                                            Theme.of(context)
                                                .colorScheme
                                                .onPrimary
                                                .withOpacity(0.3),
                                            const Color(0xFFFEC8D1),
                                            const Color(0xFFFEC8D1),
                                            Colors.white,
                                          ],
                                        ),
                                      ),
                                      child: Text(
                                        "What's attracts the reader towards a review."
                                            .toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                                fontSize: 20,
                                                color: Colors.black),
                                      )),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Expanded(
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: bloc.reviewList.length,
                                          itemBuilder: (context, index) =>
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  width: 0.6.sw,
                                                  child: Column(children: [
                                                    Expanded(
                                                      child: bloc
                                                                  .reviewList[
                                                                      index]
                                                                  .type ==
                                                              "FileType.image"
                                                                  .toString()
                                                          ? Image.network(
                                                              bloc
                                                                  .reviewList[
                                                                      index]
                                                                  .file,
                                                              fit: BoxFit
                                                                  .contain,
                                                            )
                                                          : VideoPlayer(VideoPlayerController.networkUrl(
                                                              Uri.parse(bloc
                                                                  .reviewList[
                                                                      index]
                                                                  .file),
                                                              videoPlayerOptions:
                                                                  VideoPlayerOptions(
                                                                      allowBackgroundPlayback:
                                                                          false))
                                                            ..initialize()),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      bloc.reviewList[index]
                                                          .review,
                                                      maxLines: 2,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                  ]))))
                                ],
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          width: 1.sw,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withOpacity(0.7),
                                Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withOpacity(0.3),
                                const Color(0xFFFEC8D1),
                                const Color(0xFFFEC8D1),
                                Colors.white,
                              ],
                            ),
                          ),
                          child: Text(
                            "Products",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5.0,
                                  mainAxisSpacing: 7.0,
                                  mainAxisExtent: 230),
                          itemCount: bloc.productItem.length,
                          itemBuilder: (context, index) => InkWell(
                              onTap: () => {
                                    context.push(AppPaths.product,
                                        extra: bloc.productItem[index])
                                  },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(1, 1),
                                        blurRadius: 2,
                                        color: Colors.grey,
                                      )
                                    ]),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        bloc.productItem[index].image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                                bloc.productItem[index].name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500)),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                              child: bloc.productItem[index]
                                                  .getPrice())
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        bloc.productItem[index].desc,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    )
                                  ],
                                ),
                              ))),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(),
                      Container(
                        width: 1.sw,
                        height: 50,
                        color: Colors.white,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () => callLink(
                                      "https://www.facebook.com/people/FarmFresh/100093691961032/"),
                                  icon: const Icon(
                                    FontAwesomeIcons.facebook,
                                    size: 26,
                                  )),
                              IconButton(
                                  onPressed: () => callLink(
                                      "https://in.pinterest.com/OfficialCoralHaze/_created/"),
                                  icon: const Icon(
                                    FontAwesomeIcons.pinterest,
                                    size: 26,
                                  )),
                              IconButton(
                                  onPressed: () => callLink(
                                      "https://instagram.com/_farmfreshindia?utm_source=qr&igshid=MzNlNGNkZWQ4Mg%3D%3D"),
                                  icon: const Icon(
                                    FontAwesomeIcons.instagram,
                                    size: 26,
                                  )),
                            ],
                          ),
                        ), //const Color(0xFFE6D3D8),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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

  callLink(String link) async {
    if (await canLaunchUrl(Uri.parse(link))) {
      await launchUrl(Uri.parse(link));
    }
  }

  List<Widget> getPage(BuildContext context, HomeBloc bloc) {
    final pagerList = <Widget>[];
    for (int i = 0; i < bloc.banner.length; i++) {
      pagerList.add(Card(
        child: GestureDetector(
          onTap: () => {
            context.push(AppPaths.categoryDetail, extra: bloc.banner[i].cateory)
          },
          child: ClipRRect(
            child: Image.network(bloc.banner[i].image,
                width: 1.sw, fit: BoxFit.fill),
          ),
        ),
      ));
    }
    bloc.autoPlayBanner(bloc.banner);
    return pagerList;
  }

  Widget productItem(ProductItem mostOrderproductItem, BuildContext context) {
    return InkWell(
        onTap: () =>
            {context.push(AppPaths.product, extra: mostOrderproductItem)},
        child: Container(
          padding: const EdgeInsets.all(5),
          width: 0.5.sw,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(1, 1),
                  blurRadius: 2,
                  color: Colors.grey,
                )
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Image.network(
                  mostOrderproductItem.image,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(mostOrderproductItem.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(child: mostOrderproductItem.getPrice())
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  mostOrderproductItem.desc,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.normal),
                ),
              )
            ],
          ),
        ));
  }
}
