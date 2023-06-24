import 'package:farmfresh/module/delivery_addess_module/add_address_module/addAddress/add_address_bloc.dart';
import 'package:farmfresh/module/delivery_addess_module/add_address_module/add_address_repository.dart';
import 'package:farmfresh/utility/app_storage.dart';
import 'package:farmfresh/utility/ui/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:place_picker/entities/location_result.dart';

class AddAddressView extends StatelessWidget {
  final LocationResult location;
  const AddAddressView({super.key, required this.location});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Address"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          child: RepositoryProvider(
            create: (context) => AddAddressRepository(),
            child: BlocProvider(
              create: (context) => AddAddressBloc(location, context.read()),
              child: BlocBuilder<AddAddressBloc, AddAddressState>(
                builder: (context, state) {
                  var bloc = context.read<AddAddressBloc>();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state is AddAddressErrorState
                          ? Text(
                              state.message,
                              style: const TextStyle(color: Colors.red),
                            )
                          : const SizedBox(),
                      Text(
                        "Full Name*",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.onPrimary),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            initialValue: AppStorage().userDetail?.name,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8),
                              hintText: 'Enter name',
                            ),
                            onChanged: (value) => bloc.name = value),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Flat, House no, Apartment",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.onPrimary),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8),
                              hintText: 'Enter Flat, House no, Apartment',
                            ),
                            onChanged: (value) => bloc.house = value),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Area, Colony, Street, Sector, Village",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.onPrimary),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            initialValue: location.formattedAddress,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8),
                              hintText: 'Area, Colony, Street, Sector, Village',
                            ),
                            onChanged: (value) => bloc.address = value),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Contact Number",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.onPrimary),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            initialValue: AppStorage().userDetail?.phoneNumber,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8),
                              hintText: 'Enter contact number',
                            ),
                            onChanged: (value) => bloc.mobileNo = value),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          RadioMenuButton(
                            value: "Home",
                            groupValue: bloc.type,
                            onChanged: (value) =>
                                {bloc.add(ChangeTypeEvent(value ?? ""))},
                            child: const Text("Home"),
                          ),
                          RadioMenuButton(
                            value: "Office",
                            groupValue: bloc.type,
                            onChanged: (value) =>
                                {bloc.add(ChangeTypeEvent(value ?? ""))},
                            child: const Text("Office"),
                          ),
                          RadioMenuButton(
                            value: "Other",
                            groupValue: bloc.type,
                            onChanged: (value) =>
                                {bloc.add(ChangeTypeEvent(value ?? ""))},
                            child: const Text("Other"),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: BlocListener<AddAddressBloc, AddAddressState>(
                            listener: (context, state) {
                              if (state is MoveBackState) {
                                context.pop();
                              }
                            },
                            child: CustomButton(
                                text: state is AddAddressLoading
                                    ? "Loading..."
                                    : "Save Address",
                                onPressed: () =>
                                    {bloc.add(SaveAddressEvent())}),
                          ))
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
