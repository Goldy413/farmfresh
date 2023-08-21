import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfresh/module/checkout_module/model/place_order.dart';
import 'package:farmfresh/module/order_module/order_list_module/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderRepository repo;
  List<PlaceOrder> orderList = [];
  OrderBloc(this.repo) : super(OrderInitial()) {
    on<OrderEvent>((event, emit) {});
    on<ChangeOrder>((event, emit) => emit(OrderSuccesfully()));

    on<GetOrderEvent>((event, emit) => repo.getOrder(
        orderCallback: (category) => {
              orderList.clear(),
              for (DocumentSnapshot dataRef in category.docs)
                {
                  orderList.add(PlaceOrder.fromJson(
                      dataRef.data() as Map<String, dynamic>)),
                  add(ChangeOrder())
                },
            }));
  }
}
