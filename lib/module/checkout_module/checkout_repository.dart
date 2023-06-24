import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfresh/module/login_module/model/login_model.dart';
import 'package:farmfresh/utility/app_constants.dart';

class CheckoutRepository {
  Future<void> getAddress(String userId,
      {required Function(List<Address> addressItem) addressCallback}) async {
    FirebaseFirestore.instance
        .collection(CollectionConstant.address)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .listen((product) {
      List<Address> addressItem = <Address>[];
      for (DocumentSnapshot dataRef in product.docs) {
        addressItem
            .add(Address.fromJson(dataRef.data() as Map<String, dynamic>));
      }
      addressCallback(addressItem);
    });
  }
}
