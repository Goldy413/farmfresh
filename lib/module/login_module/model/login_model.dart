import 'dart:convert';

class UserInfo {
  UserInfo({
    required this.id,
    required this.username,
    required this.email,
    //required this.password,
    //  required this.resetPasswordOTP,
    //required this.supervisor,
    required this.companyId,
    this.designation = "",
    this.iRole = "",
    this.mobile = "",
    this.companyName = "",
  });
  late final int id;
  late final String username;
  late final String email;
  //late final String password;
  // late final String resetPasswordOTP;
  //late final String supervisor;
  late final int companyId;
  late final String designation;
  late final String iRole;
  late final String mobile;
  late final String companyName;
  factory UserInfo.fromRawJson(String str) =>
      UserInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    //password = json['password'];
    // resetPasswordOTP = json['resetPasswordOTP'];
    //supervisor = json['supervisor'] ?? 0;
    companyId = json['companyId'];
    companyName = json['companyName'] ?? "";

    designation = json['designation'] ?? "";
    iRole = json['iRole'] ?? "";
    mobile = json['mobile'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    // data['password'] = password;
    // data['resetPasswordOTP'] = resetPasswordOTP;
    //data['supervisor'] = supervisor;
    data['companyId'] = companyId;
    data['designation'] = designation;
    data['iRole'] = iRole;
    data['mobile'] = mobile;

    return data;
  }
}
