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
  Ban({
    required this.image,
    required this.cateoryId,
  });
  late String image;
  late String cateoryId;

  Ban.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    cateoryId = json['cateoryId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['cateoryId'] = cateoryId;
    return data;
  }
}
