import 'dart:math';

import 'package:farmfresh/module/bag_module/bag_repository.dart';
import 'package:farmfresh/module/bag_module/model/bag_model.dart';
import 'package:farmfresh/module/checkout_module/model/delivery_area.dart';
import 'package:farmfresh/module/login_module/model/login_model.dart';
import 'package:farmfresh/utility/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:place_picker/place_picker.dart';

part 'bag_event.dart';
part 'bag_state.dart';

class BagBloc extends Bloc<BagEvent, BagState> {
  late BagModel bagModel;
  BagRepository repo;
  List<DeliveryArea> deliveryAreaItems = [];
  List<Address> addressItem = [];
  BagBloc(this.repo) : super(BagInitial()) {
    var userDetail = AppStorage().userDetail!;
    bagModel = AppStorage().userBag ??
        BagModel(
            id: "",
            userId: userDetail.uid,
            userName: userDetail.name,
            items: []);

    //set delivery charge
    bagModel.deliveryCharge = 20.00;
    on<GetBagEvent>((event, emit) async {
      await repo.getBag((bag) => {bagModel = bag, add(ChangeStateEvent())});
    });

    on<DataChangeEvent>((event, emit) {
      if (addressItem.isNotEmpty) {
        bagModel.deliveryCharge = _getDeliveryCharge(addressItem.first);
        emit(ChangeState());
      }
    });

    on<GetAddressEvent>((event, emit) async {
      await repo.getAddress(
        bagModel.userId,
        addressCallback: (addresss) {
          addressItem = addresss;
          add(ChangeStateEvent());
        },
      );
    });
    on<RemoveItemsEvent>((event, emit) async {
      bagModel.items.removeAt(event.index);
      await repo.addBag(bagModel: bagModel);
      emit(ChangeState());
    });

    on<ClearCartEvent>((event, emit) async {
      bagModel.items.clear();
      await repo.addBag(bagModel: bagModel);
      emit(ClearBagState());
    });
    on<GetDeliveryAreaEvent>((event, emit) async {
      await repo.getDeliveryArea(delilveryAreaCallBack: (items) {
        deliveryAreaItems = items;
        add(DataChangeEvent());
      });
    });
    on<ChangeStateEvent>((event, emit) {
      bagModel = AppStorage().userBag ??
          BagModel(
              id: "",
              userId: userDetail.uid,
              userName: userDetail.name,
              items: []);

      emit(ChangeState());
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
    return calculateItemTotal() + max(0, bagModel.deliveryCharge);
  }

  int itemCount() {
    int count = 0;
    for (CartItems item in bagModel.items) {
      count = count + item.qty;
    }
    return count;
  }

  double _getDeliveryCharge(Address first) {
    deliveryAreaItems.sort(((a, b) => a.price.compareTo(b.price)));
    for (var delievryArea in deliveryAreaItems) {
      if (checkInPolyGon(
          LatLng(first.latitude, first.logitude), delievryArea.area)) {
        return delievryArea.price;
      }
    }

    return -1;
  }
}

bool checkInPolyGon(LatLng tap, List<Area> vertices) {
  int intersectCount = 0;
  for (int j = 0; j < vertices.length - 1; j++) {
    if (rayCastIntersect(tap, vertices[j], vertices[j + 1])) {
      intersectCount++;
    }
  }

  return ((intersectCount % 2) == 1); // odd = inside, even = outside;
}

bool rayCastIntersect(LatLng tap, Area vertA, Area vertB) {
  double aY = vertA.lat;
  double bY = vertB.lat;
  double aX = vertA.log;
  double bX = vertB.log;
  double pY = tap.latitude;
  double pX = tap.longitude;

  if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
    return false; // a and b can't both be above or below pt.y, and a or
    // b must be east of pt.x
  }

  double m = (aY - bY) / (aX - bX); // Rise over run
  double bee = (-aX) * m + aY; // y = mx + b
  double x = (pY - bee) / m; // algebra is neat!

  return x > pX;
}
