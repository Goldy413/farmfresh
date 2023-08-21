import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfresh/module/order_module/order_list_module/model/place_order.dart';
import 'package:farmfresh/utility/app_constants.dart';

class OrderDetailRepository {
  Future<void> changeStatus(
      {required PlaceOrder placeOrder, required String status}) async {
    try {
      await FirebaseFirestore.instance
          .collection(CollectionConstant.orders)
          .doc(placeOrder.id)
          .update({"status": status});
    } on FirebaseException catch (err) {
      throw err.message.toString();
    }
  }
}
