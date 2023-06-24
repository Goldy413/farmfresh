import 'dart:convert';

class UserModel {
  String name;
  String email;
  String bio;
  String profilePic;
  String createdAt;
  String phoneNumber;
  String uid;

  UserModel({
    required this.name,
    required this.email,
    required this.bio,
    required this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    required this.uid,
  });
  factory UserModel.fromRawJson(String str) =>
      UserModel.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      bio: map['bio'] ?? '',
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
      profilePic: map['profilePic'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "bio": bio,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
    };
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
