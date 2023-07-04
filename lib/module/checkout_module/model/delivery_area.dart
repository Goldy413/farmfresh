class DeliveryArea {
  DeliveryArea(
      {required this.id,
      required this.area,
      required this.price,
      required this.isActive});
  late String id;
  late List<Area> area;
  late double price;
  late bool isActive;

  DeliveryArea.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    area = List.from(json['area']).map((e) => Area.fromJson(e)).toList();
    price = json['price'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['area'] = area.map((e) => e.toJson()).toList();
    data['price'] = price;
    data['isActive'] = isActive;
    return data;
  }
}

class Area {
  Area({
    required this.lat,
    required this.log,
  });
  late double lat;
  late double log;

  Area.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    log = json['log'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['log'] = log;
    return data;
  }
}
