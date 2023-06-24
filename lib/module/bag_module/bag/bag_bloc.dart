import 'package:farmfresh/module/bag_module/bag_repository.dart';
import 'package:farmfresh/module/bag_module/model/bag_model.dart';
import 'package:farmfresh/utility/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bag_event.dart';
part 'bag_state.dart';

class BagBloc extends Bloc<BagEvent, BagState> {
  late BagModel bagModel;
  BagRepository repo;
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
    on<GetBagEvent>((event, emit) {
      repo.getBag(() => {add(ChangeStateEvent())});
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
