import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:safra/backend/authError.dart';

class Storage {
  static final FirebaseStorage storage = FirebaseStorage.instance;

  static Future<void> uploadFile(String imgPath, String imgName) async {
    File file = File(imgPath);

    try {
      await storage.ref('profile_images/$imgName').putFile(file);
    } on FirebaseException catch (e) {
      print(e);
      authError.showSnackBar(e.message);
    }
  }

  static Future readImage(String imgName) async {
    String downloadURL =
        await storage.ref('profile_images/$imgName').getDownloadURL();
    return downloadURL;
  }
}
