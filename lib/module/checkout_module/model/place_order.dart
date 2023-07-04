import 'package:farmfresh/module/bag_module/model/bag_model.dart';
import 'package:farmfresh/module/checkout_module/model/payment_method_model.dart';
import 'package:farmfresh/module/login_module/model/login_model.dart';

class PlaceOrder {
  PlaceOrder({
    required this.id,
    required this.userId,
    required this.userName,
    required this.items,
    required this.deliveryCharge,
    required this.address,
    required this.paymentMethod,
    required this.placeAt,
    required this.createdAt,
    required this.updateAt,
    required this.status,
    required this.itemsTotal,
    required this.total,
    required this.transactionId,
  });
  late String id;
  late String userId;
  late String userName;
  late List<CartItems> items;
  late double deliveryCharge;
  late Address address;
  late PaymentMethod paymentMethod;
  late String placeAt;
  late String createdAt;
  late String updateAt;
  late int status;
  late double itemsTotal;
  late double total;
  late String transactionId;

  PlaceOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    userName = json['userName'];
    items = json['items'] == null
        ? []
        : List.from(json['items']).map((e) => CartItems.fromJson(e)).toList();
    deliveryCharge = json['deliveryCharge'];
    address = Address.fromJson(json['address']);
    paymentMethod = PaymentMethod.fromJson(json['paymentMethod']);
    placeAt = json['placeAt'];
    createdAt = json['createdAt'];
    updateAt = json['updateAt'];
    status = json['status'];
    itemsTotal = json['itemsTotal'];
    total = json['total'];
    transactionId = json['transactionId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['userName'] = userName;
    data['items'] = items.map((e) => e.toJson()).toList();

    data['deliveryCharge'] = deliveryCharge;
    data['address'] = address.toJson();
    data['paymentMethod'] = paymentMethod.toJson();
    data['placeAt'] = placeAt;
    data['createdAt'] = createdAt;
    data['updateAt'] = updateAt;
    data['status'] = status;
    data['itemsTotal'] = itemsTotal;
    data['total'] = total;
    data['transactionId'] = transactionId;
    return data;
  }
}

class AdminModel {
  AdminModel({
    required this.uid,
    required this.fcmToken,
  });
  late final String uid;
  late final String fcmToken;

  AdminModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    fcmToken = json['fcmToken'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['fcmToken'] = fcmToken;
    return data;
  }
}
