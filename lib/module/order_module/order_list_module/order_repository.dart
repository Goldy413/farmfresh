import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfresh/utility/app_constants.dart';

class OrderRepository {
  Future<void> getOrder(
      {required Function(QuerySnapshot category) orderCallback}) async {
    FirebaseFirestore.instance
        .collection(CollectionConstant.orders)
        .snapshots()
        .listen((event) {
      orderCallback(event);
    });
  }
}
