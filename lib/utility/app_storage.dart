import 'package:farmfresh/module/login_module/model/login_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppStorage {
  static final AppStorage _singleton = AppStorage._internal();

  factory AppStorage() {
    return _singleton;
  }
  AppStorage._internal();

  final String _prefrenceName = "farm_fresh_prefrence";
  late Box _box;

  Future<AppStorage> _init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_prefrenceName);
    return this;
  }

  static Future<AppStorage> objectValue() async {
    return await AppStorage()._init();
  }

  UserInfo? get userDetail {
    final userRawJson = _box.get("user_detail");
    if (userRawJson is String) {
      return UserInfo.fromRawJson(userRawJson);
    }
    return null;
  }

  set userDetail(UserInfo? userInfo) =>
      _box.put("user_detail", userInfo?.toRawJson());

  bool isLoggedIn() => userDetail?.id != null;
}
