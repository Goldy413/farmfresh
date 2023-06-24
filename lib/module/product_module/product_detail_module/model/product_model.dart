import 'dart:convert';

class ProductItem {
  ProductItem({
    required this.id,
    required this.name,
    required this.actualPrice,
    required this.discountPrice,
    required this.categoryId,
    required this.categoryName,
    required this.subCategoryName,
    required this.subCategoryId,
    required this.desc,
    required this.isActive,
    required this.createdAt,
    required this.image,
  });
  late String id;
  late String name;
  late double actualPrice;
  late double discountPrice;
  late String categoryId;
  late String categoryName;
  late String subCategoryName;
  late String subCategoryId;
  late String desc;
  late bool isActive;
  late String image;
  late String createdAt;
  late Varient varient;

  factory ProductItem.fromRawJson(String str) =>
      ProductItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  ProductItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    actualPrice = double.tryParse(json['actualPrice'] ?? "0.0") ?? 0.0;
    discountPrice = double.tryParse(json['discountPrice'] ?? "0.0") ?? 0.0;

    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    subCategoryName = json['subCategoryName'];
    subCategoryId = json['subCategoryId'];
    desc = json['desc'];
    isActive = json['isActive'];
    image = json['image'];
    createdAt = json['createdAt'] ?? "";
    varient = json['varient'] != null
        ? Varient.fromJson(json['varient'])
        : Varient(color: [], size: []);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['actualPrice'] = actualPrice;
    data['discountPrice'] = discountPrice;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['subCategoryName'] = subCategoryName;
    data['subCategoryId'] = subCategoryId;
    data['desc'] = desc;
    data['isActive'] = isActive;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['varient'] = varient.toJson();
    return data;
  }
}

class Varient {
  Varient({
    required this.size,
    required this.color,
  });
  late final List<ProductSize> size;
  late final List<ProductColor> color;

  factory Varient.fromRawJson(String str) => Varient.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  Varient.fromJson(Map<String, dynamic> json) {
    size = List.from(json['size']).map((e) => ProductSize.fromJson(e)).toList();
    color =
        List.from(json['color']).map((e) => ProductColor.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['size'] = size.map((e) => e.toJson()).toList();
    data['color'] = color.map((e) => e.toJson()).toList();
    return data;
  }
}

class ProductSize {
  ProductSize({
    required this.name,
    required this.price,
  });
  late String name;
  late double price;

  ProductSize.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = double.parse(json['price'] ?? "0.0");
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}

class ProductColor {
  ProductColor({
    required this.name,
    required this.color,
    required this.price,
  });
  late String name;
  late String color;
  late double price;

  ProductColor.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
    price = double.parse(json['price'] ?? "0.0");
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['color'] = color;
    data['price'] = price;
    return data;
  }
}

// {"id":"123","name":"iPhone","actualPrice":"10.12","discountPrice":"8.90","categoryId":"123","categoryName":"Brand","subCategoryName":"phone","subCategoryId":"bold","desc":"this is product","isActive":true,"image":""}