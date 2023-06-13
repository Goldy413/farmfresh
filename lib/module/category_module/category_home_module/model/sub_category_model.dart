import 'dart:convert';

import 'package:farmfresh/module/product_module/product_detail_module/model/product_model.dart';

class SubCategoryItem {
  SubCategoryItem({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.subCategoryName,
    required this.image,
    required this.isActive,
    required this.desc,
    required this.createdAt,
  });
  late String id;
  late String categoryId;
  late String categoryName;
  late String subCategoryName;
  late String image;
  late bool isActive;
  late String desc;
  late String createdAt;
  late List<ProductItem> productItem = [];

  factory SubCategoryItem.fromRawJson(String str) =>
      SubCategoryItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  SubCategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    subCategoryName = json['subCategoryName'];
    image = json['image'];
    isActive = json['isActive'];
    desc = json['desc'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['subCategoryName'] = subCategoryName;
    data['image'] = image;
    data['isActive'] = isActive;
    data['desc'] = desc;
    data['createdAt'] = createdAt;
    return data;
  }
}
