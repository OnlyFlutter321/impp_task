import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:impp_task/Utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;
  // FirebaseDatabase databaseRef = FirebaseDatabase.instance;
  File? _image;
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future getGalleryImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {});
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print("No Image Pick");
      // Utils().toMessaage("No Image Picks");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase "),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () {
                getGalleryImage();
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                height: 200,
                width: 200,
                child: _image != null
                    ? Image.file(
                        _image!.absolute,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Icon(Icons.image),
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width * 0.4,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  firebase_storage.Reference ref = firebase_storage
                      .FirebaseStorage.instance
                      .ref('/foldername/' +
                          DateTime.now().millisecondsSinceEpoch.toString());

                  firebase_storage.UploadTask uploadTask =
                      ref.putFile(_image!.absolute);

                  Future.value(uploadTask).then((value) async {
                    var newUrl = await ref.getDownloadURL();
                    setState(() {
                      loading = false;
                    });
                    Utils().toMessaage('uploaded');
                  }).onError((error, stackTrace) {
                    Utils().toMessaage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
                },
                child: Center(
                  child: loading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Upload",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
