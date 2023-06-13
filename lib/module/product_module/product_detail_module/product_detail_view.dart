import 'package:farmfresh/module/product_module/product_detail_module/model/product_model.dart';
import 'package:farmfresh/module/product_module/product_detail_module/productDetail/product_detail_bloc.dart';
import 'package:farmfresh/module/product_module/product_detail_module/product_detail_repository.dart';
import 'package:farmfresh/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          ..add(GetProductDetailEvent()),
        child: Scaffold(
          body: CustomScrollView(slivers: [
            BlocBuilder<ProductDetailBloc, ProductDetailState>(
              builder: (context, state) {
                var bloc = context.read<ProductDetailBloc>();

                return SliverAppBar(
                  toolbarHeight: 80,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            bloc.productItem.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600),
                          ),
                          bloc.productItem.getPrice(isSingleLine: true)
                        ],
                      ),
                    ),
                  ),
                  elevation: 0,
                  pinned: true,
                  backgroundColor: Colors.white,
                  expandedHeight: 300.0,
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
                  var bloc = context.read<ProductDetailBloc>();
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            bloc.productItem.varient.size.isNotEmpty
                                ? Card(
                                    shape:
                                        Border.all(color: Colors.transparent),
                                    elevation: 1,
                                    child: ExpansionTile(
                                        initiallyExpanded: true,
                                        backgroundColor: Colors.white,
                                        shape: Border.all(
                                            color: Colors.transparent),
                                        tilePadding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        title: Text(
                                          "Available Size",
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
                                            child: Wrap(
                                              children: [
                                                for (int index = 0;
                                                    index <
                                                        bloc.productItem.varient
                                                            .size.length;
                                                    index++)
                                                  InkWell(
                                                    onDoubleTap: () => {
                                                      bloc.productItem.varient
                                                          .size
                                                          .removeAt(index),
                                                      // bloc.add(
                                                      //     DeleteVarientEvent(
                                                      //         bloc.productItem))
                                                    },
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8.0,
                                                                horizontal: 16),
                                                        child: Text(
                                                            bloc
                                                                .productItem
                                                                .varient
                                                                .size[index]
                                                                .name,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          )
                                        ]),
                                  )
                                : const SizedBox(),
                            bloc.productItem.varient.color.isNotEmpty
                                ? Card(
                                    shape:
                                        Border.all(color: Colors.transparent),
                                    elevation: 1,
                                    child: ExpansionTile(
                                        initiallyExpanded: true,
                                        backgroundColor: Colors.white,
                                        shape: Border.all(
                                            color: Colors.transparent),
                                        tilePadding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        title: Text(
                                          "Available Colors",
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
                                            child: Wrap(
                                              children: [
                                                for (int colorIndex = 0;
                                                    colorIndex <
                                                        bloc.productItem.varient
                                                            .color.length;
                                                    colorIndex++)
                                                  InkWell(
                                                    onDoubleTap: () => {
                                                      bloc.productItem.varient
                                                          .color
                                                          .removeAt(colorIndex),
                                                      // bloc.add(
                                                      //     DeleteVarientEvent(
                                                      //         bloc.productItem))
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: 35,
                                                          height: 35,
                                                          margin:
                                                              const EdgeInsets
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
                                                        Text(
                                                            bloc
                                                                .productItem
                                                                .varient
                                                                .color[
                                                                    colorIndex]
                                                                .name,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium)
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          )
                                        ]),
                                  )
                                : const SizedBox(),
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
                                    "Descriptions",
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
                          ]));
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
