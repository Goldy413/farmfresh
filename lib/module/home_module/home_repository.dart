import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfresh/module/home_module/model/banner_model.dart';
import 'package:farmfresh/module/home_module/model/review_model.dart';
import 'package:farmfresh/module/product_module/product_detail_module/model/product_model.dart';
import 'package:farmfresh/utility/app_constants.dart';

class HomeRepository {
  List<DocumentSnapshot> newDocumentList = [];
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

  Future<void> getReview(
      {required Function(List<ReviewModel> reviewList) callback}) async {
    FirebaseFirestore.instance
        .collection(CollectionConstant.review)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .listen((event) {
      List<ReviewModel> reviewList = [];
      for (DocumentSnapshot dataRef in event.docs) {
        reviewList
            .add(ReviewModel.fromJson(dataRef.data() as Map<String, dynamic>));
      }
      callback(reviewList);
    });
  }

  Future<void> getFirstList(
      {required Function(List<ProductItem> reviewList) callback}) async {
    FirebaseFirestore.instance
        .collection(CollectionConstant.product)
        .where('isActive', isEqualTo: true)
        .limit(10)
        .snapshots()
        .listen((product) {
      newDocumentList = product.docs;
      List<ProductItem> productItem = <ProductItem>[];
      for (DocumentSnapshot dataRef in product.docs) {
        productItem
            .add(ProductItem.fromJson(dataRef.data() as Map<String, dynamic>));
      }
      callback(productItem);
    });
  }

  Future<void> fetchNextProduct(List<ProductItem> reviewList,
      {required Function(List<ProductItem> reviewList) callback}) async {
    FirebaseFirestore.instance
        .collection(CollectionConstant.product)
        .where('isActive', isEqualTo: true)
        .startAfterDocument(newDocumentList[newDocumentList.length - 1])
        .limit(10)
        .snapshots()
        .listen((product) {
      newDocumentList.addAll(product.docs);
      List<ProductItem> productItem = <ProductItem>[];
      for (DocumentSnapshot dataRef in product.docs) {
        productItem
            .add(ProductItem.fromJson(dataRef.data() as Map<String, dynamic>));
      }
      callback(productItem);
    });
  }
}
