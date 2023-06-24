import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfresh/module/category_module/category_home_module/model/category.dart';
import 'package:farmfresh/module/category_module/category_home_module/model/sub_category_model.dart';
import 'package:farmfresh/module/product_module/product_detail_module/model/product_model.dart';
import 'package:farmfresh/utility/app_constants.dart';

class CategoryDetailRepository {
  Future<void> deleteSubCategory(
      {required SubCategoryItem subCategoryItem}) async {
    try {
      QuerySnapshot collection = await FirebaseFirestore.instance
          .collection(CollectionConstant.product)
          .where("subCategoryId", isEqualTo: subCategoryItem.id)
          .get();

      for (var element in collection.docs) {
        await FirebaseFirestore.instance
            .collection(CollectionConstant.product)
            .doc(element.get("id"))
            .delete();
      }

      await FirebaseFirestore.instance
          .collection(CollectionConstant.subCategory)
          .doc(subCategoryItem.id)
          .delete();
    } on FirebaseException catch (err) {
      throw err.message.toString();
    }
  }

  Future<void> changeStatus({required CategoryItem categoryItem}) async {
    try {
      await FirebaseFirestore.instance
          .collection(CollectionConstant.category)
          .doc(categoryItem.id)
          .set(categoryItem.toJson());
    } on FirebaseException catch (err) {
      throw err.message.toString();
    }
  }

  Future<void> getSubCategory(
      {required Function(List<SubCategoryItem> subCategoryItem)
          categoryCallback,
      required CategoryItem category}) async {
    FirebaseFirestore.instance
        .collection(CollectionConstant.subCategory)
        .where("categoryId", isEqualTo: category.id)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .listen((category) async {
      List<SubCategoryItem> subCategoryItem = <SubCategoryItem>[];
      for (DocumentSnapshot dataRef in category.docs) {
        subCategoryItem.add(
            SubCategoryItem.fromJson(dataRef.data() as Map<String, dynamic>));
      }
      categoryCallback(subCategoryItem);
    });
  }

  Future<void> getSubCategoryProduct(
      {required Function(List<ProductItem> productItem) productCallback,
      required SubCategoryItem subCategory}) async {
    FirebaseFirestore.instance
        .collection(CollectionConstant.product)
        .where("subCategoryId", isEqualTo: subCategory.id)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .listen((product) {
      List<ProductItem> productItem = <ProductItem>[];
      for (DocumentSnapshot dataRef in product.docs) {
        productItem
            .add(ProductItem.fromJson(dataRef.data() as Map<String, dynamic>));
      }
      // subCategory.productItem = productItem;
      productCallback(productItem);
    });
  }

  Future<void> getCategoryProduct(
      {required Function(List<ProductItem> productItem) productCallback,
      required CategoryItem category}) async {
    FirebaseFirestore.instance
        .collection(CollectionConstant.product)
        .where('categoryId', isEqualTo: category.id)
        .where("subCategoryId", isEqualTo: "")
        .where('isActive', isEqualTo: true)
        .snapshots()
        .listen((product) {
      List<ProductItem> productItem = <ProductItem>[];
      for (DocumentSnapshot dataRef in product.docs) {
        productItem
            .add(ProductItem.fromJson(dataRef.data() as Map<String, dynamic>));
      }
      productCallback(productItem);
    });
  }
}
