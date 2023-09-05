import 'package:farmfresh/module/category_module/category_home_module/model/category.dart';

class BannerModel {
  BannerModel({required this.banner, required this.id});
  late List<Ban> banner;
  late String id;

  BannerModel.fromJson(Map<String, dynamic> json) {
    banner = json['banner'] == null
        ? []
        : List.from(json['banner']).map((e) => Ban.fromJson(e)).toList();
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['banner'] = banner.map((e) => e.toJson()).toList();
    data['id'] = id;
    return data;
  }
}

class Ban {
  Ban({required this.image, required this.cateory, required this.isActive});
  late String image;
  late CategoryItem? cateory;
  late bool isActive;

  Ban.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    cateory =
        json['cateory'] != null ? CategoryItem.fromJson(json['cateory']) : null;
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['cateory'] = cateory?.toJson();
    data['isActive'] = isActive;
    return data;
  }
}
