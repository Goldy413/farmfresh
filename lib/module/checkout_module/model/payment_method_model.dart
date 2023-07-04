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
    marchantName = json['marchantName'];
    key = json['key'];
    type = json['type'];
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
