import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:farmfresh/module/login_module/model/login_model.dart';
import 'package:farmfresh/utility/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ProfileRepository {
  Future<void> updateProfile(String uid, String name, String email, String bio,
      String phone, File image,
      {required Function(UserModel userModel) onComplete}) async {
    UserModel userModel = UserModel(
      uid: uid,
      name: name,
      email: email,
      bio: bio,
      phoneNumber: phone,
      profilePic: "",
      createdAt: "",
    );
    try {
      await storeFileToStorage("profilePic/$uid", image).then((value) {
        userModel.profilePic = value;
        userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
      });

      // uploading to database
      await FirebaseFirestore.instance
          .collection(CollectionConstant.user)
          .doc(uid)
          .set(userModel.toMap())
          .then((value) {});

      await getDataFromFirestore(uid, onComplete);
    } on FirebaseAuthException catch (err) {
      throw err.message.toString();
    }
  }

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    XFile? result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 88,
      rotate: 180,
    );
    if (result == null) {
      return file;
    } else {
      return File(result.path);
    }
  }

  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask =
        FirebaseStorage.instance.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> getDataFromFirestore(
      String uid, Function(UserModel userModel) userCallBack) async {
    await FirebaseFirestore.instance
        .collection(CollectionConstant.user)
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      UserModel userModel = UserModel.fromMap(snapshot as Map<String, dynamic>);

      // UserModel(
      //   name: snapshot['name'],
      //   email: snapshot['email'],
      //   createdAt: snapshot['createdAt'],
      //   bio: snapshot['bio'],
      //   uid: snapshot['uid'],
      //   profilePic: snapshot['profilePic'],
      //   phoneNumber: snapshot['phoneNumber'],
      //   address:
      // );

      userCallBack(userModel);
    });
  }
}
