import 'package:farmfresh/module/bag_module/model/bag_model.dart';
import 'package:farmfresh/module/checkout_module/model/place_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_detail_event.dart';
part 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  final PlaceOrder order;
  String selectedStatus = "Placed";
  List<String> statusValue = [
    "Cancel",
    "Placed",
    "Processing",
    "Out for Delivery",
    "Delivered"
  ];
  OrderDetailBloc(this.order, this.selectedStatus)
      : super(OrderDetailInitial()) {
    on<OrderDetailEvent>((event, emit) {});
    on<StatusChangedEvent>((event, emit) => {
          selectedStatus = event.status,
          order.status = selectedStatus,
          emit(ChangeStatusState())
        });
  }

  int itemCount() {
    int count = 0;
    for (CartItems item in order.items) {
      count = count + item.qty;
    }
    return count;
  }

  getStatus(String status) {
    statusValue.clear();
    if (status.toLowerCase() == "Placed".toLowerCase()) {
      statusValue.add("Processing");
      statusValue.add("Out for Delivery");
      statusValue.add("Delivered");
    } else if (status.toLowerCase() == "Processing".toLowerCase()) {
      statusValue.add("Out for Delivery");
      statusValue.add("Delivered");
    } else if (status.toLowerCase() == "Out for Delivery".toLowerCase()) {
      statusValue.add("Delivered");
    } else {}
  }
}
