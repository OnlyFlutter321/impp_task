import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FireStoreDataBase {
  fs.Reference? storage;
  io.File? _image;
  final firebase_storage.FirebaseStorage storage1 =
      firebase_storage.FirebaseStorage.instance;
  String? downloadUrl;

  // Future getData() async {
  //   try {
  //     await downloadUrlExample();
  //     return downloadUrl;
  //   } catch (e) {
  //     debugPrint("Error $e");
  //     return null;
  //   }
  // }
  //
  // Future<void> downloadUrlExample() async {
  //   downloadUrl = await FirebaseStorage.instance
  //       .ref()
  //       .child('product/${Path.basename(_image!.path)}')
  //       .getDownloadURL();
  //   debugPrint(downloadUrl.toString());
  // }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult result = await storage1!.ref('test').listAll();
    result.items.forEach((firebase_storage.Reference ref) {
      print("images file: $ref");
    });
    return result;
  }

  Future<String> downloadUrl1(String imageName) async {
    String downloadUrl = await storage1.ref('test/$imageName').getDownloadURL();
    return downloadUrl;
  }
}
