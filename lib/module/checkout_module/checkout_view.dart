import 'package:farmfresh/module/bag_module/model/bag_model.dart';
import 'package:farmfresh/module/checkout_module/checkout/checkout_bloc.dart';
import 'package:farmfresh/module/checkout_module/checkout_repository.dart';
import 'package:farmfresh/routes.dart';
import 'package:farmfresh/utility/app_constants.dart';
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
          create: (context) =>
              CheckoutBloc(bagModel, context.read())..add(GetAddressEvent()),
          child: BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              var bloc = context.read<CheckoutBloc>();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
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
                              height: 0.4.sw,
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
                                                          width: 10,
                                                        ),
                                                        Text(
                                                            bloc
                                                                .addressItem[
                                                                    index]
                                                                .name,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium)
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      "${bloc.addressItem[index].house} ${bloc.addressItem[index].address}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium,
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Icon(
                                                        bloc.addressItem[index]
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
                                                            ? Theme.of(context)
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
                                                    )
                                                  ],
                                                )
                                                //  RadioMenuButton(
                                                //   value: bloc.addressItem[index].id,
                                                //   groupValue:
                                                //       bloc.selectedAddress?.id,
                                                //   onChanged: (value) {
                                                //     bloc.add(ChangeAddressEvent(
                                                //         bloc.addressItem[index]));
                                                //   },
                                                //   child: Text(bloc
                                                //       .addressItem[index].address),
                                                // ),
                                                ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delivery Charge",
                                  style: Theme.of(context).textTheme.labelLarge,
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
