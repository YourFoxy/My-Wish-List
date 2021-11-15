import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Myrw extends StatefulWidget {
  Myrw({Key? key}) : super(key: key);

  @override
  _MyrwState createState() => _MyrwState();
}

class _MyrwState extends State<Myrw> {
  Future pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    File file = File(image!.path);
    var storage = FirebaseStorage.instance;
    TaskSnapshot snapshot = await storage.ref().child("images/k").putFile(file);
    //var storageReference =
    // await FirebaseStorage.instance.ref().child('uploads/${image.path}');
    //var uploadTask = storageReference.putFile(file);

    // String returnURL = '';
    //await storageReference.getDownloadURL().then((fileURL) {
    //   returnURL = fileURL;
    //  });
    //print("returnURLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA:  ${returnURL}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          pickImage();
        },
        child: const Icon(Icons.add),
      ),
      body: Container(),
    );
  }
}
