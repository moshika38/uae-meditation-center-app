import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uae_meditation_center/data/models/user.model.dart';
import 'package:uae_meditation_center/main.dart';
// import 'package:cloudinary_api/src/request/model/uploader_params.dart';

class UserProvider extends ChangeNotifier {
  // update user
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> updateUser(UserModel user) async {
    final docRef = _firestore.collection('users').doc(
          FirebaseAuth.instance.currentUser!.uid,
        );

    try {
      await docRef.update({...user.toJson()});
      notifyListeners();
      return true;
    } catch (e) {
      notifyListeners();
      print('Error updating task: $e');
      return false;
    }
  }

  // get user by id
  Future<UserModel> getUserById(String id) async {
    final snapshot = await _firestore.collection('users').doc(id).get();

    return UserModel.fromJson(snapshot.data()!);
  }

//upload User Profile Image
  // Future<bool> uploadUserProfileImage(
  //   XFile imagePath,
  //   String userID,
  //   BuildContext context,
  //   UserModel currentUser,
  // ) async {
  //   try {
  //     final File file = File(imagePath.path);
  //     var response = await cloudinary.uploader().upload(
  //           file,
  //           params: UploadParams(
  //             publicId: userID,
  //             uniqueFilename: false,
  //             overwrite: true,
  //             folder: "users",
  //           ),
  //         );

  //     debugPrint("Secure URL: ${response?.data?.secureUrl}");
  //     if (response?.data?.secureUrl != null) {
  //       // new profile image url
  //       final profileImage = response?.data?.secureUrl;
  //       // update user collection
  //       final uploadStatus = await updateUser(
  //         UserModel(
  //           name: currentUser.name,
  //           email: currentUser.email,
  //           uid: currentUser.uid,
  //           profileImage: profileImage.toString(),
  //           isAdmin: false,
  //         ),
  //       );

  //       if (uploadStatus) {
  //         return true;
  //       } else {
  //         debugPrint("image uploaded but unable to update user");

  //         //TODO:delete image from cloudinary
  //         return false;
  //       }
  //     } else {
  //       debugPrint("Upload failed");
  //     }
  //   } catch (e) {
  //     debugPrint("Upload uploading and update user/ failed: $e");
  //     return false;
  //   }
  //   return false;
  // }
}
