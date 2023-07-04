import 'dart:convert';

class BagModel {
  BagModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.items,
  });
  late String id;
  late String userId;
  late String userName;
  late double deliveryCharge = 0.0;
  late List<CartItems> items = [];

  factory BagModel.fromRawJson(String str) =>
      BagModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  BagModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    userName = json['userName'];
    deliveryCharge = json['deliveryCharge'] ?? 0.0;
    items = json['items'] == null
        ? []
        : List.from(json['items']).map((e) => CartItems.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['userName'] = userName;

    data['deliveryCharge'] = deliveryCharge;
    data['items'] = items.map((e) => e.toJson()).toList();
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
