import 'package:farmfresh/module/bag_module/model/bag_model.dart';
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

  set token(String? token) => _box.put("token", token);

  String? get token {
    final token = _box.get("token");
    return token;
  }

  UserModel? get userDetail {
    final userRawJson = _box.get("user_detail");
    if (userRawJson is String) {
      return UserModel.fromRawJson(userRawJson);
    }
    return null;
  }

  set userDetail(UserModel? userInfo) =>
      _box.put("user_detail", userInfo?.toRawJson());

  BagModel? get userBag {
    final userRawJson = _box.get("user_bag");
    if (userRawJson is String) {
      return BagModel.fromRawJson(userRawJson);
    }
    return null;
  }

  set userBag(BagModel? userInfo) =>
      _box.put("user_bag", userInfo?.toRawJson());

  bool isLoggedIn() => userDetail?.uid != null;

  bool isOnBoardingShowed() {
    final onBoardingShowed = _box.get("onBoardingShowed") ?? false;
    if (onBoardingShowed is bool) {
      return onBoardingShowed;
    }
    return false;
  }

  onBoardingShowed(bool newval) => _box.put("onBoardingShowed", newval);
}
