import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfresh/module/product_module/product_detail_module/model/product_model.dart';
import 'package:farmfresh/utility/app_constants.dart';

class ProductDetailRepository {
  // Future<void> changeStatus({required ProductItem productItem}) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection(CollectionConstant.product)
  //         .doc(productItem.id)
  //         .set(productItem.toJson());
  //   } on FirebaseException catch (err) {
  //     throw err.message.toString();
  //   }
  // }

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
