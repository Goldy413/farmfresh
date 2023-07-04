import 'package:farmfresh/module/bag_module/model/bag_model.dart';
import 'package:farmfresh/module/checkout_module/checkout/checkout_bloc.dart';
import 'package:farmfresh/module/checkout_module/checkout_repository.dart';
import 'package:farmfresh/routes.dart';
import 'package:farmfresh/utility/app_constants.dart';
import 'package:farmfresh/utility/custom_material_button.dart';
import 'package:farmfresh/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:place_picker/place_picker.dart';

class CheckoutView extends StatelessWidget {
  final BagModel bagModel;
  const CheckoutView({super.key, required this.bagModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: RepositoryProvider(
        create: (context) => CheckoutRepository(),
        child: BlocProvider(
          create: (context) => CheckoutBloc(bagModel, context.read())
            ..add(GetAddressEvent())
            ..add(GetPaymentMethodEvent()),
          child: BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              var bloc = context.read<CheckoutBloc>();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Delivery Address",
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                                BlocListener<CheckoutBloc, CheckoutState>(
                                  listener: (context, state) async {
                                    if (state is AddAddressState) {
                                      await Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => PlacePicker(
                                                    AppConstant.apiKey,
                                                    displayLocation: LatLng(
                                                        state.userLocation
                                                            .latitude,
                                                        state.userLocation
                                                            .longitude),
                                                  )))
                                          .then((result) => {
                                                context.push(
                                                    AppPaths.addaddress,
                                                    extra: result)
                                              });
                                    }
                                  },
                                  child: InkWell(
                                    onTap: () {
                                      bloc.add(AddDeliveryAddressEvent());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          state is AddAddressLoadingState
                                              ? "Loading..."
                                              : "Add",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge
                                              ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 1.sw,
                              height: 0.36.sw,
                              child: bloc.addressItem.isEmpty
                                  ? const Center(
                                      child: Text("Please (+) add address."),
                                    )
                                  : ListView.builder(
                                      physics: const ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: bloc.addressItem.length,
                                      itemBuilder: (context, index) => Card(
                                              child: InkWell(
                                            onTap: () => {
                                              bloc.add(ChangeAddressEvent(
                                                  bloc.addressItem[index]))
                                            },
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                width: 0.4.sw,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.check_circle,
                                                          color: bloc
                                                                      .addressItem[
                                                                          index]
                                                                      .id ==
                                                                  bloc.selectedAddress
                                                                      ?.id
                                                              ? Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary
                                                              : Colors.grey,
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                bloc
                                                                    .addressItem[
                                                                        index]
                                                                    .name,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleMedium),
                                                            Text(
                                                                bloc
                                                                    .addressItem[
                                                                        index]
                                                                    .contactNo,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .labelSmall),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${bloc.addressItem[index].house} ${bloc.addressItem[index].address}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            bloc
                                                                .addressItem[
                                                                    index]
                                                                .type
                                                                .toUpperCase(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium
                                                                ?.copyWith(
                                                                    color: bloc.addressItem[index].type.toLowerCase() ==
                                                                            'home'
                                                                        ? Theme.of(context)
                                                                            .colorScheme
                                                                            .primary
                                                                        : bloc.addressItem[index].type.toLowerCase() ==
                                                                                'office'
                                                                            ? Colors.blue
                                                                            : Theme.of(context).colorScheme.onPrimary)),
                                                        Icon(
                                                          bloc
                                                                      .addressItem[
                                                                          index]
                                                                      .type
                                                                      .toLowerCase() ==
                                                                  'home'
                                                              ? Icons.home
                                                              : bloc
                                                                          .addressItem[
                                                                              index]
                                                                          .type
                                                                          .toLowerCase() ==
                                                                      'office'
                                                                  ? Icons
                                                                      .corporate_fare_outlined
                                                                  : Icons
                                                                      .location_pin,
                                                          color: bloc
                                                                      .addressItem[
                                                                          index]
                                                                      .type
                                                                      .toLowerCase() ==
                                                                  'home'
                                                              ? Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary
                                                              : bloc
                                                                          .addressItem[
                                                                              index]
                                                                          .type
                                                                          .toLowerCase() ==
                                                                      'office'
                                                                  ? Colors.blue
                                                                  : Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .onPrimary,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                          ))),
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
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
                            if (bloc.bagModel.deliveryCharge < 0)
                              Text(
                                  "Delivery is not available on your prime address.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.red)),
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
                                  bloc.calculateItemTotal().toformat(),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                )
                              ],
                            ),
                            if (bloc.bagModel.deliveryCharge >= 0)
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
                                    bloc.bagModel.deliveryCharge.toformat(),
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
                                  bloc.calTotal().toformat(),
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
                      height: 5,
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Choose Payment",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    bloc.paymentMethodItems.isEmpty
                        ? SizedBox(
                            width: 1.sw,
                            height: 100,
                            child: const Center(
                              child: Text("Payment methood no available"),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: bloc.paymentMethodItems.length,
                            itemBuilder: (context, index) => Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: InkWell(
                                    onTap: () => {
                                      bloc.add(ChangePaymentMethodEvent(
                                          bloc.paymentMethodItems[index]))
                                    },
                                    child: ListTile(
                                      title: Text(
                                        bloc.paymentMethodItems[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      trailing: Icon(
                                        Icons.check_circle,
                                        color: bloc.paymentMethodItems[index]
                                                    .id ==
                                                bloc.selectedPaymentMethod?.id
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                )),
                    const SizedBox(
                      height: 0,
                    ),
                    state is CheckoutErrorState
                        ? Text(
                            state.message,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: BlocListener<CheckoutBloc, CheckoutState>(
                          listener: (context, state) {
                            if (state is OrderPlacedSucessfully) {
                              context.pop();
                            }
                          },
                          child: CustomMaterialButton(
                            onPressed: () => {bloc.add(OnPlaceOrderEvent())},
                            buttonText: 'Place Order',
                          )

                          // GradientSlideToAct(
                          //   width: 400,
                          //   dragableIcon: Icons.arrow_forward_ios,
                          //   textStyle: const TextStyle(
                          //       color: Colors.white, fontSize: 15),
                          //   backgroundColor:
                          //       Theme.of(context).colorScheme.primary,
                          //   onSubmit: () {
                          //     bloc.add(OnPlaceOrderEvent());
                          //   },
                          //   gradient: LinearGradient(
                          //       begin: Alignment.centerLeft,
                          //       colors: [
                          //         Theme.of(context).colorScheme.primary,
                          //         Theme.of(context).colorScheme.onPrimary
                          //       ]),
                          // ),
                          ),
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
