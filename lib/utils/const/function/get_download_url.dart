import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class GetDownloadUrl {
  static Future<String?> getGownloadVideoUrl(File file) async {
    log('file exist ${await file.exists()}');
    String? imageUrl;
    String UniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceroot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceroot.child('videos');
    Reference referenceImageToUpload = referenceDirImages.child(UniqueFileName);
    try {
      await referenceImageToUpload.putFile(file);
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (e) {
      log('doenload url $e');
    }
    return imageUrl;
  }
}
