import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfresh/module/bag_module/model/bag_model.dart';
import 'package:farmfresh/module/checkout_module/model/delivery_area.dart';
import 'package:farmfresh/module/login_module/model/login_model.dart';
import 'package:farmfresh/utility/app_constants.dart';
import 'package:farmfresh/utility/app_storage.dart';

class BagRepository {
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

  Future<void> getDeliveryArea(
      {required Function(List<DeliveryArea> items)
          delilveryAreaCallBack}) async {
    FirebaseFirestore.instance
        .collection(CollectionConstant.deliveryArea)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .listen((paymentMethod) {
      List<DeliveryArea> paymentMethodItems = <DeliveryArea>[];
      for (DocumentSnapshot dataRef in paymentMethod.docs) {
        paymentMethodItems
            .add(DeliveryArea.fromJson(dataRef.data() as Map<String, dynamic>));
      }
      delilveryAreaCallBack(paymentMethodItems);
    });
  }

  Future<void> getBag(Function callback) async {
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
      callback(AppStorage().userBag ??
          BagModel(
              id: "",
              userId: userdetail.uid,
              userName: userdetail.name,
              items: []));
    });
  }
}
