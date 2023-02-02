import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class ImagesDetails extends StatefulWidget {
  const ImagesDetails({Key? key}) : super(key: key);

  @override
  State<ImagesDetails> createState() => _ImagesDetailsState();
}

class _ImagesDetailsState extends State<ImagesDetails> {
  HomePage homePage = new HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Images Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text(
                            snapshot.data!.docs[index].get('description'),
                          ),
                          Container(
                            width: 300,
                            height: 250,
                            child: Image.network(
                              snapshot.data!.docs[index].get('imgURL'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    primary: false,
                  );
                } else {
                  return SizedBox();
                }
              },
              stream: FirebaseFirestore.instance
                  .collection('imagesData')
                  .snapshots(),
            ),
          ],
        ),
      ),
    );
  }
}

/*


body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Search Image",
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
                height: 26,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                height: 200,
                width: 300,
              ),
            ],
          ),
        ),
      ),
 */
