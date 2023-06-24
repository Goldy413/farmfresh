import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfresh/module/login_module/model/login_model.dart';
import 'package:farmfresh/utility/app_constants.dart';

class AddAddressRepository {
  Future<void> addAddress(Address address, {required Function callback}) async {
    DocumentReference response = await FirebaseFirestore.instance
        .collection(CollectionConstant.address)
        .add({});
    address.id = response.id;

    await FirebaseFirestore.instance
        .collection(CollectionConstant.address)
        .doc(response.id)
        .set(address.toJson());

    callback();
  }
}
