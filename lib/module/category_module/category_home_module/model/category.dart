import 'dart:convert';

class CategoryItem {
  CategoryItem(
      {required this.id,
      required this.categoryName,
      required this.image,
      required this.createdAt,
      required this.isActive,
      required this.desc});
  late final String id;
  late final String categoryName;
  late final String image;
  late bool isActive;
  late final String createdAt;
  late final String desc;

  factory CategoryItem.fromRawJson(String str) =>
      CategoryItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  CategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
    image = json['image'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['categoryName'] = categoryName;
    data['image'] = image;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['desc'] = desc;
    return data;
  }
}
