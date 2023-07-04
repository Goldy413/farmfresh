import 'package:farmfresh/module/bag_module/bag/bag_bloc.dart';
import 'package:farmfresh/module/bag_module/bag_repository.dart';
import 'package:farmfresh/module/bag_module/view/empty_bag.dart';
import 'package:farmfresh/routes.dart';
import 'package:farmfresh/utility/extensions.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BagView extends StatelessWidget {
  const BagView({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => BagRepository(),
      child: BlocProvider(
        create: (context) => BagBloc(context.read())
          ..add(GetBagEvent())
          ..add(GetAddressEvent())
          ..add(GetDeliveryAreaEvent()),
        child: BlocBuilder<BagBloc, BagState>(
          builder: (context, state) {
            var bloc = context.read<BagBloc>();
            return Scaffold(
                floatingActionButton: bloc.bagModel.items.isEmpty
                    ? null
                    : FloatingActionButton.extended(
                        isExtended: true,
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        icon: const Icon(Icons.payment, size: 20),
                        label: Text('Checkout'.toUpperCase()),
                        onPressed: () {
                          context.push(AppPaths.checkout, extra: bloc.bagModel);
                        },
                      ),
                body: bloc.bagModel.items.isEmpty
                    ? const Center(
                        child: EmptyBag(),
                      )
                    : CustomScrollView(
                        slivers: [
                          CupertinoSliverNavigationBar(
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            largeTitle: Text(
                              'My Bag',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          SliverToBoxAdapter(
                              child: SingleChildScrollView(
                                  child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 80.0),
                                      child: Column(children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).splashColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15.0, top: 4.0),
                                            child: Row(
                                              children: [
                                                const SizedBox(
                                                  width: 25.0,
                                                ),
                                                Text(
                                                  'Total'.toUpperCase(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontSize: 14),
                                                ),
                                                const SizedBox(width: 8.0),
                                                Text(
                                                  '${bloc.bagModel.items.length} Items',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: BlocListener<BagBloc,
                                                        BagState>(
                                                      listener:
                                                          (context, state) {
                                                        if (state
                                                            is ClearBagState) {
                                                          callFlash(
                                                              context,
                                                              "Bag Clear",
                                                              "Your bag clear successfully.");
                                                        }
                                                      },
                                                      child: TextButton(
                                                        child: Text(
                                                          'Clear Cart'
                                                              .toUpperCase(),
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .redAccent,
                                                              fontSize: 12),
                                                        ),
                                                        onPressed: () =>
                                                            clearCart(
                                                                context, bloc),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            itemCount:
                                                bloc.bagModel.items.length,
                                            itemBuilder:
                                                (context, index) => Column(
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              IconButton(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .remove_circle_outline),
                                                                onPressed: () =>
                                                                    {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return AlertDialog(
                                                                          content:
                                                                              const Text('Are you sure you want to delete item?'),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: const Text('Keep'),
                                                                            ),
                                                                            MaterialButton(
                                                                              onPressed: () {
                                                                                bloc.add(RemoveItemsEvent(index));
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              color: Theme.of(context).colorScheme.onPrimary,
                                                                              child: const Text(
                                                                                'Remove',
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      })
                                                                },
                                                              ),
                                                              Expanded(
                                                                  child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Image.network(
                                                                    bloc
                                                                        .bagModel
                                                                        .items[
                                                                            index]
                                                                        .image,
                                                                    width: 1.sw *
                                                                        0.20,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          16.0),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                                child: Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  bloc.bagModel.items[index].name,
                                                                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                                                        color: Theme.of(context).colorScheme.primary,
                                                                                      ),
                                                                                  maxLines: 4,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                ),
                                                                                const SizedBox(height: 7),
                                                                                Text(
                                                                                  bloc.bagModel.items[index].price.toformat(),
                                                                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black87, fontWeight: FontWeight.w500),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                            Container(
                                                                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                                              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: const BorderRadius.all(Radius.circular(5)), shape: BoxShape.rectangle),
                                                                              child: Text(
                                                                                "x${bloc.bagModel.items[index].qty}",
                                                                                style: Theme.of(context).textTheme.titleMedium,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                5),
                                                                        bloc.bagModel.items[index].color.isNotEmpty
                                                                            ? Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  const Text("Colors"),
                                                                                  Text(
                                                                                    bloc.bagModel.items[index].color,
                                                                                    textAlign: TextAlign.center,
                                                                                    style: Theme.of(context).textTheme.titleSmall,
                                                                                  )
                                                                                ],
                                                                              )
                                                                            : const SizedBox(),
                                                                        bloc.bagModel.items[index].size.isNotEmpty
                                                                            ? Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  const Text("Size"),
                                                                                  Text(
                                                                                    bloc.bagModel.items[index].size,
                                                                                    textAlign: TextAlign.center,
                                                                                    style: Theme.of(context).textTheme.titleSmall,
                                                                                  )
                                                                                ],
                                                                              )
                                                                            : const SizedBox()
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              )),
                                                              const SizedBox(
                                                                  width: 16.0),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 10.0),
                                                          const Divider(
                                                              color: Color(
                                                                  0xFFEEEEEE),
                                                              height: 1),
                                                          const SizedBox(
                                                              height: 10.0),
                                                        ])),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Card(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          color: Colors.white,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0, vertical: 10),
                                            width: 1.sw,
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                if (bloc.bagModel
                                                        .deliveryCharge <
                                                    0)
                                                  Text(
                                                      "Delivery is not available on your prime address.",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.red)),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Items Total (${bloc.itemCount()} items)",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge,
                                                    ),
                                                    Text(
                                                      bloc
                                                          .calculateItemTotal()
                                                          .toformat(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium,
                                                    )
                                                  ],
                                                ),
                                                if (bloc.bagModel
                                                        .deliveryCharge >=
                                                    0)
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Delivery Charge",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelLarge,
                                                      ),
                                                      Text(
                                                        bloc.bagModel
                                                            .deliveryCharge
                                                            .toformat(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium,
                                                      )
                                                    ],
                                                  ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Total Payable",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge
                                                          ?.copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary),
                                                    ),
                                                    Text(
                                                      bloc
                                                          .calTotal()
                                                          .toformat(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge
                                                          ?.copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ]))))
                        ],
                      ));
          },
        ),
      ),
    );
  }

  void callFlash(BuildContext context, String title, String message) {
    context.showFlash(
        duration: const Duration(seconds: 3),
        barrierDismissible: true,
        builder: (context, controller) => FlashBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              controller: controller,
              behavior: FlashBehavior.floating,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
              ),
              position: FlashPosition.top,
              margin: const EdgeInsets.all(5.0),
              clipBehavior: Clip.antiAlias,
              icon: const Icon(Icons.check),
              title: Text(title),
              content: Text(message),
            ));
  }

  void clearCart(BuildContext context, BagBloc bloc) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text('Are you sure you want to clear the cart?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Keep'),
              ),
              MaterialButton(
                onPressed: () {
                  bloc.add(ClearCartEvent());
                  Navigator.of(context).pop();
                },
                color: Theme.of(context).colorScheme.onPrimary,
                child: const Text(
                  'Clear',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
