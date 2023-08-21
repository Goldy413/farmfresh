import 'package:farmfresh/module/order_module/order_detail_module/orderDetail/order_detail_bloc.dart';
import 'package:farmfresh/module/order_module/order_list_module/model/place_order.dart';
import 'package:farmfresh/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailView extends StatelessWidget {
  final PlaceOrder order;
  const OrderDetailView({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (context) => OrderDetailBloc(order, order.status),
          child: BlocBuilder<OrderDetailBloc, OrderDetailState>(
            builder: (context, state) {
              var bloc = context.read<OrderDetailBloc>();
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 0.2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order From : ${bloc.order.userName}",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  "Order on : ${bloc.order.placeAt.toStringFormat("dd MMM yyyy")}",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  "Payment : ${bloc.order.paymentMethod.name}",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  "No of Items : ${bloc.order.items.length}",
                                  style: Theme.of(context).textTheme.titleSmall,
                                )
                              ],
                            )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Amt",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  bloc.order.total.toformat(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(color: Colors.green),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Items".toUpperCase(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemCount: bloc.order.items.length,
                        itemBuilder: (context, index) => Column(children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        bloc.order.items[index].image,
                                        width: 1.sw * 0.20,
                                        fit: BoxFit.fill,
                                      ),
                                      const SizedBox(width: 16.0),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      bloc.order.items[index]
                                                          .name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium
                                                          ?.copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                          ),
                                                      maxLines: 4,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(height: 7),
                                                    Text(
                                                      bloc.order.items[index]
                                                          .price
                                                          .toformat(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.copyWith(
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                )),
                                                Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  5)),
                                                      shape:
                                                          BoxShape.rectangle),
                                                  child: Text(
                                                    "x${bloc.order.items[index].qty}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            bloc.order.items[index].color
                                                    .isNotEmpty
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text("Colors"),
                                                      Text(
                                                        bloc.order.items[index]
                                                            .color,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      )
                                                    ],
                                                  )
                                                : const SizedBox(),
                                            bloc.order.items[index].size
                                                    .isNotEmpty
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text("Size"),
                                                      Text(
                                                        bloc.order.items[index]
                                                            .size,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      )
                                                    ],
                                                  )
                                                : const SizedBox()
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                                  const SizedBox(width: 16.0),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              const Divider(
                                  color: Color(0xFFEEEEEE), height: 1),
                              const SizedBox(height: 10.0),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Items Total (${bloc.itemCount()} items)",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                Text(
                                  order.itemsTotal.toformat(),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                )
                              ],
                            ),
                            if (order.deliveryCharge >= 0)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Delivery Charge",
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  Text(
                                    order.deliveryCharge.toformat(),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  )
                                ],
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Payable",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                ),
                                Text(
                                  order.total.toformat(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Change Order Status : ",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        DropdownButton<String>(
                          //isExpanded: true,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          value: bloc.selectedStatus,
                          items: bloc.statusValue
                              .map((String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            bloc.add(StatusChangedEvent(value ?? "Placed"));
                          },
                          underline: const SizedBox(),
                          hint: Expanded(
                            child: Text(
                              "Select Type Status",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
