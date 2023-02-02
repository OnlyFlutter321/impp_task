import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadImageDetailsScreen extends StatefulWidget {
  const UploadImageDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageDetailsScreen> createState() =>
      _UploadImageDetailsScreenState();
}

class _UploadImageDetailsScreenState extends State<UploadImageDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
