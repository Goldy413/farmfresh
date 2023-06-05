import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfresh/module/login_module/model/login_model.dart';
import 'package:farmfresh/utility/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerificationRepository {
  Future<void> verifiOTP({
    required String verifyId,
    required String otp,
    required Function(UserModel userModel) userCallBack,
    required Function(String uid) userNotExist,
  }) async {
    try {
      PhoneAuthCredential creds =
          PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);
      User? user =
          (await FirebaseAuth.instance.signInWithCredential(creds)).user;
      if (user != null) {
        await checkExistingUser(user.uid).then((value) async {
          if (value) {
            await getDataFromFirestore(user.uid, userCallBack);
          } else {
            userNotExist(user.uid);
          }
        });
      }
    } on FirebaseAuthException catch (err) {
      throw err.message.toString();
    }
  }

  // DATABASE OPERTAIONS
  Future<bool> checkExistingUser(String uid) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(CollectionConstant.user)
        .doc(uid)
        .get();
    if (snapshot.exists) {
      //print("USER EXISTS");
      return true;
    } else {
      //print("NEW USER");
      return false;
    }
  }

  Future<void> getDataFromFirestore(
      String uid, Function(UserModel userModel) userCallBack) async {
    await FirebaseFirestore.instance
        .collection(CollectionConstant.user)
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      UserModel userModel = UserModel(
        name: snapshot['name'],
        email: snapshot['email'],
        createdAt: snapshot['createdAt'],
        bio: snapshot['bio'],
        uid: snapshot['uid'],
        profilePic: snapshot['profilePic'],
        phoneNumber: snapshot['phoneNumber'],
      );

      userCallBack(userModel);
    });
  }
}
