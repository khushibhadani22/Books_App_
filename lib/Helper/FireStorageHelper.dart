import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHelper {
  FirebaseStorageHelper._();
  static final FirebaseStorageHelper firebaseStorageHelper =
      FirebaseStorageHelper._();

  Reference storageRef = FirebaseStorage.instance.ref();

  uploadFile({required String imagePath, required String bId}) {
    final spaceRef = storageRef.child("images/$bId.jpg");

    File file = File(imagePath);

    try {
      spaceRef.putFile(file).toString();
    } catch (e) {
      print("Error :- $e");
    }
  }

  Future<String> getImageURL({required String bId}) async {
    String imageURL =
        await storageRef.child("image./$bId.jpg").getDownloadURL();

    print("URL :- $imageURL");

    return imageURL;
  }
}
