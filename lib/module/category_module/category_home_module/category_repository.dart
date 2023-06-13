import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfresh/utility/app_constants.dart';

class CategoryRepository {
  Future<void> getCategory(
      {required Function(QuerySnapshot category) categoryCallback}) async {
    FirebaseFirestore.instance
        .collection(CollectionConstant.category)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .listen((event) {
      categoryCallback(event);
    });
  }
}
