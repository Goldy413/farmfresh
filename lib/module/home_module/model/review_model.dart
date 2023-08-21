import 'dart:convert';

class ReviewModel {
  ReviewModel(
      {required this.review,
      required this.file,
      required this.type,
      required this.isActive,
      required this.id});
  late String review;
  late String file;
  late String type;
  late bool isActive;
  late String id;

  ReviewModel.fromJson(Map<String, dynamic> json) {
    review = json['review'] ?? "";
    file = json['file'];
    type = json['type'];
    isActive = json['isActive'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['review'] = review;
    data['file'] = file;
    data['type'] = type;
    data['isActive'] = isActive;
    data['id'] = id;
    return data;
  }

  factory ReviewModel.fromRawJson(String str) =>
      ReviewModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}
