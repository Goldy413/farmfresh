import 'dart:convert';
import 'package:farmfresh/utility/extensions.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfresh/module/checkout_module/model/delivery_area.dart';
import 'package:farmfresh/module/checkout_module/model/payment_method_model.dart';
import 'package:farmfresh/module/checkout_module/model/place_order.dart';
import 'package:farmfresh/module/login_module/model/login_model.dart';
import 'package:farmfresh/utility/app_constants.dart';
import 'package:flutter/foundation.dart';

class CheckoutRepository {
  List<AdminModel> admin = [];
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

    List<AdminModel> adminRes = [];
    FirebaseFirestore.instance
        .collection(CollectionConstant.adminUser)
        .snapshots()
        .listen((event) {
      for (DocumentSnapshot dataRef in event.docs) {
        adminRes
            .add(AdminModel.fromJson(dataRef.data() as Map<String, dynamic>));
      }

      admin = adminRes;
    });
  }

  Future<void> getPaymentMethod(
      {required Function(List<PaymentMethod> items)
          paymentMethodCallBack}) async {
    FirebaseFirestore.instance
        .collection(CollectionConstant.paymentMethod)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .listen((paymentMethod) {
      List<PaymentMethod> paymentMethodItems = <PaymentMethod>[];
      for (DocumentSnapshot dataRef in paymentMethod.docs) {
        paymentMethodItems.add(
            PaymentMethod.fromJson(dataRef.data() as Map<String, dynamic>));
      }
      paymentMethodCallBack(paymentMethodItems);
    });
  }

  Future<void> placeOrder(PlaceOrder placeorder,
      {required Function callback}) async {
    DocumentReference response = await FirebaseFirestore.instance
        .collection(CollectionConstant.orders)
        .add({});
    placeorder.id = response.id;
    placeorder.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
    placeorder.placeAt = DateTime.now();
    //.millisecondsSinceEpoch.toString();
    // DateTime()
    await FirebaseFirestore.instance
        .collection(CollectionConstant.orders)
        .doc(response.id)
        .set(placeorder.toJson());

    for (AdminModel element in admin) {
      sendPushMessage("You receive a new ${placeorder.total.toformat()} order.",
          "New Order", element.fcmToken);
    }

    callback();
  }

  Future<void> deleteBag(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection(CollectionConstant.bag)
          .doc(id)
          .delete();
    } on FirebaseException catch (err) {
      throw err.message.toString();
    }
  }

  void sendPushMessage(String body, String title, String token) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAhe45rAA:APA91bGI7DwB75IsuMSEwAzl_6Qx49qs38qkHJ81l3CxB_iGn-FoucEuEoGUHRoCpJTrFuAvdFS00yRNtTWrP88xgNny1u22BzIs1HCQs1TW0Mr3-7FBQdGXEREXsoeTWhiSA5hIOeE9',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      debugPrint("error push notification");
    }
  }
}
