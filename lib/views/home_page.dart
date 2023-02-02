import 'dart:io' as io;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController descriptionController = TextEditingController();

  io.File? _image;
  final picker = ImagePicker();

  fs.Reference? ref;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase "),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  _chooseImage();
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
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: TextFormField(
                controller: descriptionController,
                minLines: 2,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Enter Description",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
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
                  onPressed: () {
                    _uploadFile();
                  },
                  child: Center(
                    child: Text(
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
      ),
    );
  }

  Future<void> _retrieveLostData(File selectedImage) async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        selectedImage = File(response.file!.path);
      });
    } else {
      print(response.file);
    }
  }

  Future _uploadFile() async {
    if (descriptionController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter description");
    } else {
      _showMyDialog();
      String imageUrl = "";
      if (_image != null) {
        imageUrl = await uploadImage();
      }

      DateTime now = DateTime.now();
      FirebaseFirestore.instance.collection('imagesData').add({
        "description": descriptionController.text,
        'imgURL': imageUrl,
        'enteredDate': now,
        'created': now.millisecondsSinceEpoch
      }).whenComplete(() {
        Fluttertoast.showToast(msg: 'Data Added Successfully');
        Navigator.of(context).pop();
      });
    }
  }

  Future<String> uploadImage() async {
    ref = fs.FirebaseStorage.instance
        .ref()
        .child('product/${Path.basename(_image!.path)}');
    await ref!.putFile(_image!);
    return await ref!.getDownloadURL();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Loading'),
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 10,
              ),
              Text("Please wait...")
            ],
          ),
        );
      },
    );
  }

  _chooseImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    print(pickedFile!.path);
    print(pickedFile.name);
    setState(() {
      _image = File(pickedFile.path);
    });
    print(_image!.path);
    if (pickedFile.path == null) _retrieveLostData(_image!);
  }
}
