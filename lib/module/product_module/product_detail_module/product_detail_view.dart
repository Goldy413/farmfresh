import 'package:farmfresh/module/product_module/product_detail_module/model/product_model.dart';
import 'package:farmfresh/module/product_module/product_detail_module/productDetail/product_detail_bloc.dart';
import 'package:farmfresh/module/product_module/product_detail_module/product_detail_repository.dart';
import 'package:farmfresh/routes.dart';
import 'package:farmfresh/utility/app_storage.dart';
import 'package:farmfresh/utility/extensions.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProductDetailView extends StatelessWidget {
  final ProductItem productItem;
  const ProductDetailView({
    super.key,
    required this.productItem,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ProductDetailRepository(),
      child: BlocProvider(
        create: (context) => ProductDetailBloc(context.read(), productItem)
          ..add(GetSuggestedProductEvent())
          ..add(GetProductDetailEvent()),
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton:
              BlocConsumer<ProductDetailBloc, ProductDetailState>(
            listener: (context, state) {
              if (state is ProductAddState) {
                callFlash(context, "${state.name} Added",
                    "${state.qty} ${state.name} is added into your bag.");
              }
            },
            builder: (context, state) {
              var bloc = context.read<ProductDetailBloc>();
              return FloatingActionButton.extended(
                  onPressed: () {
                    bloc.add(AddtoBagEvent());
                  },
                  isExtended: true,
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  foregroundColor: Colors.black,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  icon: const Icon(Icons.shopping_bag_outlined, size: 20),
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Add to Bag".toUpperCase()),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("Item Price"),
                          Text(bloc.price.toformat())
                        ],
                      )
                    ],
                  )
                  //,
                  );
            },
          ),
          body: CustomScrollView(slivers: [
            BlocBuilder<ProductDetailBloc, ProductDetailState>(
              builder: (context, state) {
                var bloc = context.read<ProductDetailBloc>();

                return SliverAppBar(
                  //toolbarHeight: 80,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BackButton(
                        color: Colors.black,
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            shape: const CircleBorder())),
                  ),
                  actions: [
                    MaterialButton(
                      onPressed: () => {context.push(AppPaths.bag)},
                      color: Theme.of(context).colorScheme.onPrimary,
                      shape: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Badge(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          label: (AppStorage().userBag?.items.length ?? 0) > 0
                              ? Text(
                                  '${AppStorage().userBag?.items.length}',
                                  style: const TextStyle(color: Colors.white),
                                )
                              : null,
                          child: const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(22),
                    child: Container(
                      width: 1.sw,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.sp),
                              topRight: Radius.circular(25.sp))),
                      child: Text(
                        bloc.productItem.name.toUpperCase(),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  elevation: 0,
                  pinned: true,
                  backgroundColor: Colors.white,
                  expandedHeight: 400.0,
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      bloc.productItem.image,
                      width: 1.sw,
                      //height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
                builder: (context, state) {
                  var bloc = context.read<ProductDetailBloc>()
                    ..add(GetBagEvent());
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            bloc.productItem.getPrice(isSingleLine: true),
                            const SizedBox(
                              height: 10,
                            ),
                            bloc.productItem.varient.size.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Select Size : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.w500),
                                      ),
                                      Wrap(
                                        alignment: WrapAlignment.start,
                                        children: [
                                          for (int index = 0;
                                              index <
                                                  bloc.productItem.varient.size
                                                      .length;
                                              index++)
                                            InkWell(
                                              onTap: () => {
                                                bloc.add(SelectSizeEvent(bloc
                                                    .productItem
                                                    .varient
                                                    .size[index]))
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                  ),
                                                  color: bloc.size ==
                                                          bloc
                                                              .productItem
                                                              .varient
                                                              .size[index]
                                                              .name
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary
                                                      : null,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 16),
                                                  child: Text(
                                                      bloc.productItem.varient
                                                          .size[index].name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 10,
                            ),
                            bloc.productItem.varient.color.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Select Colors :",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.w500),
                                      ),
                                      Wrap(
                                        children: [
                                          for (int colorIndex = 0;
                                              colorIndex <
                                                  bloc.productItem.varient.color
                                                      .length;
                                              colorIndex++)
                                            InkWell(
                                              onTap: () => {
                                                bloc.add(SelectColorEvent(bloc
                                                    .productItem
                                                    .varient
                                                    .color[colorIndex]))
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        width: 35,
                                                        height: 35,
                                                        margin: const EdgeInsets
                                                            .all(5.0),
                                                        decoration: BoxDecoration(
                                                            color: bloc
                                                                .productItem
                                                                .varient
                                                                .color[
                                                                    colorIndex]
                                                                .color
                                                                .toColor(),
                                                            shape: BoxShape
                                                                .circle),
                                                      ),
                                                      bloc
                                                                  .productItem
                                                                  .varient
                                                                  .color[
                                                                      colorIndex]
                                                                  .name ==
                                                              bloc.color
                                                          ? const Positioned
                                                                  .fill(
                                                              child: Icon(Icons
                                                                  .check_outlined))
                                                          : const SizedBox()
                                                    ],
                                                  ),
                                                  Text(
                                                      bloc
                                                          .productItem
                                                          .varient
                                                          .color[colorIndex]
                                                          .name,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium
                                                          ?.copyWith(
                                                              color: bloc
                                                                          .productItem
                                                                          .varient
                                                                          .color[
                                                                              colorIndex]
                                                                          .name ==
                                                                      bloc.color
                                                                  ? bloc
                                                                      .productItem
                                                                      .varient
                                                                      .color[
                                                                          colorIndex]
                                                                      .color
                                                                      .toColor()
                                                                  : Colors
                                                                      .black87))
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 15,
                            ),
                            bloc.productItem.showQty
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Select the quantity :',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 32.0,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                onPressed: () => {
                                                  bloc.add(SubtractQtyEvent())
                                                },
                                                icon: const Center(
                                                    child: Icon(
                                                  Icons.arrow_back_ios,
                                                  size: 15,
                                                )),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1.0,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              210,
                                                              208,
                                                              208)),
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                ),
                                                alignment: Alignment.center,
                                                child: TextField(
                                                  readOnly: true,
                                                  enabled: false,
                                                  maxLines: 1,
                                                  maxLength: 2,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    counterText: '',
                                                  ),
                                                  keyboardType:
                                                      const TextInputType
                                                          .numberWithOptions(
                                                    signed: false,
                                                    decimal: false,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  controller:
                                                      bloc.textController,
                                                ),
                                              )),
                                              IconButton(
                                                //padding: _iconPadding,
                                                onPressed: () =>
                                                    {bloc.add(AddQtyEvent())},
                                                icon: const Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 15,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 15,
                            ),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: InkWell(
                            //         //onTap: () => addToCart(buyNow: false, inStock: inStock),
                            //         child: Container(
                            //           height: 44,
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(3),
                            //             color: Theme.of(context).splashColor,
                            //           ),
                            //           child: Center(
                            //             child: Text(
                            //               'Buy Now'.toUpperCase(),
                            //               style: const TextStyle(
                            //                 color: Colors.black,
                            //                 fontWeight: FontWeight.bold,
                            //                 fontSize: 12,
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     const SizedBox(
                            //       width: 10,
                            //     ),
                            //     Expanded(
                            //       child: BlocListener<ProductDetailBloc,
                            //           ProductDetailState>(
                            //         listener: (context, state) {
                            //           if (state is ProductAddState) {
                            //             callFlash(
                            //                 context,
                            //                 "${state.name} Added",
                            //                 "${state.qty} ${state.name} is added into your bag.");
                            //           }
                            //         },
                            //         child: InkWell(
                            //           onTap: () => {bloc.add(AddtoBagEvent())},
                            //           child: Container(
                            //             height: 44,
                            //             decoration: BoxDecoration(
                            //               borderRadius:
                            //                   BorderRadius.circular(3),
                            //               color: Theme.of(context)
                            //                   .colorScheme
                            //                   .secondary,
                            //               // Colors.grey.withOpacity(0.2),
                            //             ),
                            //             child: Center(
                            //               child: Text(
                            //                 'Add To Bag'.toUpperCase(),
                            //                 style: const TextStyle(
                            //                   color: Colors.white,
                            //                   fontWeight: FontWeight.bold,
                            //                   fontSize: 12,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(height: 15),
                            Card(
                              shape: Border.all(color: Colors.transparent),
                              elevation: 1,
                              child: ExpansionTile(
                                  initiallyExpanded: true,
                                  backgroundColor: Colors.white,
                                  shape: Border.all(color: Colors.transparent),
                                  tilePadding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  title: Text(
                                    "Descriptions".toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 5),
                                      child: Text(bloc.productItem.desc),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ]),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            bloc.suggestedProductItem.isNotEmpty
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
                                              "May You Like : ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium
                                                  ?.copyWith(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            )),
                                        Expanded(
                                          child: ListView.separated(
                                              padding: const EdgeInsets.all(8),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: bloc
                                                  .suggestedProductItem.length,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizedBox(width: 15),
                                              itemBuilder: (context, index) {
                                                return productItemHorizontal(
                                                    bloc.suggestedProductItem[
                                                        index],
                                                    context);
                                              }),
                                        )
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 150,
                            ),
                          ]));
                },
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget productItemHorizontal(
      ProductItem mostOrderproductItem, BuildContext context) {
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

  void callFlash(BuildContext context, String title, String message) {
    context.showFlash(
        duration: const Duration(seconds: 3),
        barrierDismissible: true,
        builder: (context, controller) => FlashBar(
              backgroundColor: Colors.amber,
              controller: controller,
              behavior: FlashBehavior.floating,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
              ),
              position: FlashPosition.top,
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              clipBehavior: Clip.antiAlias,
              icon: const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
              ),
              title: Text(
                title.toUpperCase(),
                style: const TextStyle(color: Colors.black87),
              ),
              content: Text(
                message,
                style: const TextStyle(color: Colors.black87),
              ),
            ));
  }
}
