import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

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
  late DateTime placeAt;
  late String createdAt;
  late String updateAt;
  late String status;
  late double itemsTotal;
  late double total;
  late String transactionId;

  PlaceOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    userId = json['userId'];
    userName = json['userName'];
    items = json['items'] == null
        ? []
        : List.from(json['items']).map((e) => CartItems.fromJson(e)).toList();
    deliveryCharge = json['deliveryCharge'];
    address = Address.fromJson(json['address']);
    paymentMethod = PaymentMethod.fromJson(json['paymentMethod']);
    placeAt = (json['placeAt'] as Timestamp).toDate();
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
    data['placeAt'] = (placeAt as Timestamp).toDate();
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

class CartItems {
  CartItems({
    required this.image,
    required this.productId,
    required this.name,
    required this.price,
    required this.size,
    required this.color,
    required this.qty,
  });
  late String productId;
  late String name;
  late double price;
  late String size;
  late String color;
  late int qty;
  late String image;

  factory CartItems.fromRawJson(String str) =>
      CartItems.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  CartItems.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    productId = json['productId'];
    name = json['name'];
    price = json['price'];
    size = json['size'];
    color = json['color'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['productId'] = productId;
    data['name'] = name;
    data['price'] = price;
    data['size'] = size;
    data['color'] = color;
    data['qty'] = qty;
    return data;
  }
}

class Address {
  Address({
    required this.id,
    required this.name,
    required this.house,
    required this.address,
    required this.pin,
    required this.city,
    required this.state,
    required this.latitude,
    required this.logitude,
    required this.contactNo,
    required this.userId,
    required this.type,
  });
  late String id;
  late String name;
  late String house;
  late String address;
  late String pin;
  late String city;
  late String state;
  late double latitude;
  late double logitude;
  late String contactNo;
  late String userId;
  late String type;
  bool isSelected = false;

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    house = json['house'];
    address = json['address'];
    pin = json['pin'];
    city = json['city'];
    state = json['state'];
    latitude = json['latitude'];
    logitude = json['logitude'];
    contactNo = json['contactNo'];
    userId = json['userId'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['house'] = house;
    data['address'] = address;
    data['pin'] = pin;
    data['city'] = city;
    data['state'] = state;
    data['latitude'] = latitude;
    data['logitude'] = logitude;
    data['contactNo'] = contactNo;
    data['userId'] = userId;
    data['type'] = type;
    return data;
  }
}

class PaymentMethod {
  PaymentMethod({
    required this.name,
    required this.id,
    required this.marchantName,
    required this.key,
    required this.type,
    required this.isActive,
  });
  late String name;
  late String id;
  late String marchantName;
  late String key;
  late String type;
  late bool isActive;

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    id = json['id'];
    marchantName = json['marchantName'] ?? "";
    key = json['key'] ?? "";
    type = json['type'] ?? "";
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['marchantName'] = marchantName;
    data['key'] = key;
    data['type'] = type;
    data['isActive'] = isActive;
    return data;
  }
}
