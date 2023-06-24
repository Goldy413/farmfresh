import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfresh/module/bag_module/model/bag_model.dart';
import 'package:farmfresh/module/product_module/product_detail_module/model/product_model.dart';
import 'package:farmfresh/utility/app_constants.dart';
import 'package:farmfresh/utility/app_storage.dart';

class ProductDetailRepository {
  Future<void> addBag({required BagModel bagModel}) async {
    try {
      if (bagModel.id.isEmpty) {
        DocumentReference response = await FirebaseFirestore.instance
            .collection(CollectionConstant.bag)
            .add({});

        bagModel.id = response.id;
        await FirebaseFirestore.instance
            .collection(CollectionConstant.bag)
            .doc(response.id)
            .set(bagModel.toJson());
      } else {
        await FirebaseFirestore.instance
            .collection(CollectionConstant.bag)
            .doc(bagModel.id)
            .set(bagModel.toJson());
      }
    } on FirebaseException catch (err) {
      throw err.message.toString();
    }
  }

  getBag() {
    var userdetail = AppStorage().userDetail!;
    FirebaseFirestore.instance
        .collection(CollectionConstant.bag)
        .where("userId", isEqualTo: userdetail.uid)
        .snapshots()
        .listen((event) {
      List<BagModel> bagItems = [];
      for (DocumentSnapshot dataRef in event.docs) {
        bagItems.add(BagModel.fromJson(dataRef.data() as Map<String, dynamic>));
      }

      if (bagItems.isNotEmpty) {
        AppStorage().userBag = bagItems.first;
      }
    });
  }

  getProductDetail(
      String productId, Function(ProductItem productItem) productCallBack) {
    FirebaseFirestore.instance
        .collection(CollectionConstant.product)
        .doc(productId)
        .snapshots()
        .listen((event) {
      productCallBack(
          ProductItem.fromJson(event.data() as Map<String, dynamic>));
    });
  }
}
