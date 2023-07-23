import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfresh/module/home_module/model/banner_model.dart';
import 'package:farmfresh/utility/app_constants.dart';

class HomeRepository {
  Future<void> getBanner(
      {required Function(BannerModel bannerModel) callback}) async {
    FirebaseFirestore.instance
        .collection(CollectionConstant.banner)
        .snapshots()
        .listen((event) {
      List<BannerModel> bannerList = [];
      for (DocumentSnapshot dataRef in event.docs) {
        bannerList
            .add(BannerModel.fromJson(dataRef.data() as Map<String, dynamic>));
      }
      if (bannerList.isNotEmpty) {
        callback(bannerList.first);
      } else {
        callback(BannerModel(id: "", banner: []));
      }
    });
  }
}
