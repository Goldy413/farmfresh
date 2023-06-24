import 'package:farmfresh/module/bag_module/model/bag_model.dart';
import 'package:farmfresh/module/checkout_module/checkout_repository.dart';
import 'package:farmfresh/module/login_module/model/login_model.dart';
import 'package:farmfresh/utility/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final BagModel bagModel;
  CheckoutRepository repo;
  List<Address> addressItem = [];
  Address? selectedAddress;
  CheckoutBloc(this.bagModel, this.repo) : super(CheckoutInitial()) {
    on<CheckoutEvent>((event, emit) {});
    on<ChangeStateEvent>((event, emit) => emit(ChangeState()));
    on<ChangeAddressEvent>((event, emit) =>
        {selectedAddress = event.selectedAddress, emit(ChangeState())});
    on<GetAddressEvent>((event, emit) async {
      await repo.getAddress(
        bagModel.userId,
        addressCallback: (addresss) {
          addressItem = addresss;
          selectedAddress = addressItem.first;
          add(ChangeStateEvent());
        },
      );
    });
    on<AddDeliveryAddressEvent>((event, emit) async {
      emit(AddAddressLoadingState());
      Position userLocation = await Device().userPosition();
      emit(AddAddressState(userLocation));
    });
  }

  double calculateItemTotal() {
    double amt = 0.0;
    for (CartItems item in bagModel.items) {
      amt = amt + (item.price * item.qty);
    }
    return amt;
  }

  double calTotal() {
    return calculateItemTotal() + bagModel.deliveryCharge;
  }

  int itemCount() {
    int count = 0;
    for (CartItems item in bagModel.items) {
      count = count + item.qty;
    }
    return count;
  }
}
