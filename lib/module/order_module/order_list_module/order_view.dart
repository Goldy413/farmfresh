import 'package:farmfresh/module/order_module/order_list_module/order/order_bloc.dart';
import 'package:farmfresh/module/order_module/order_list_module/order_repository.dart';
import 'package:farmfresh/routes.dart';
import 'package:farmfresh/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Orders"),
        ),
        body: RepositoryProvider(
          create: (context) => OrderRepository(),
          child: BlocProvider(
            create: (context) =>
                OrderBloc(context.read())..add(GetOrderEvent()),
            child: BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                var bloc = context.read<OrderBloc>();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: bloc.orderList.length,
                      padding: const EdgeInsets.all(5),
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              context.push(AppPaths.orderDetail,
                                  extra: bloc.orderList[index]);
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Order From : ${bloc.orderList[index].userName}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        Text(
                                          "Order on : ${bloc.orderList[index].placeAt.toStringFormat("dd MMM yyyy")}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        Text(
                                          "Payment : ${bloc.orderList[index].paymentMethod.name}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        Text(
                                          "No of Items : ${bloc.orderList[index].items.length}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        )
                                      ],
                                    )),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Amt",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        Text(
                                          bloc.orderList[index].total
                                              .toformat(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(color: Colors.green),
                                        ),
                                        Text(
                                          bloc.orderList[index].status
                                              .toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                  color: getColor(bloc
                                                      .orderList[index]
                                                      .status)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                );
              },
            ),
          ),
        ));
  }

  Color getColor(String status) {
    var color = Colors.black;
    switch (status) {
      case "Cancel":
        color = Colors.red;
        break;
      case "Placed":
        color = Colors.green;
        break;

      case "Processing":
        color = Colors.blue;
        break;
      case "Out for Delivery":
        color = Colors.amber;
        break;
      case "Delivered":
        color = Colors.grey;
        break;
    }

    return color;
  }
}
