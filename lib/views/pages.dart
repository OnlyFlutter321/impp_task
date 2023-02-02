import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impp_task/views/home_page.dart';

import '../widgets/rounded_button.dart';
import 'image_details.dart';

class Pages extends StatefulWidget {
  const Pages({Key? key}) : super(key: key);

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DATA"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Choose Your Flow",
            style: GoogleFonts.ptMono(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundButton(
              title: 'Upload Image',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundButton(
              title: 'Images Details',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ImagesDetails()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
