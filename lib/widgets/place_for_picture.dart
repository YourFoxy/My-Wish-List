import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wish_list/pages/text_parameters.dart';
import 'package:wish_list/services/auth.dart';

class PlaceForPictureWidget extends StatefulWidget {
  PlaceForPictureWidget({Key? key}) : super(key: key);

  @override
  _PlaceForPictureWidgetState createState() => _PlaceForPictureWidgetState();
}

File? imageProfileFile;

class _PlaceForPictureWidgetState extends State<PlaceForPictureWidget> {
  void _getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    imageProfileFile = File(image.path);

    setState(() {
      this.image = imageProfileFile;
    });
  }

  File? image;
  Widget _picture() {
    return Container(
      height: 300,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: InkWell(
        onTap: () {
          _getImage();
        },
        child: image != null
            ? Image.file(
                image!,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              )
            : _buildImage(context),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('Users')
            .doc(fAuth.currentUser!.uid)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const TextParameters(text: '', fontSize: 20.0);
          }
          var userDocument = snapshot.data;

          return Image(
              image: NetworkImage(userDocument?['userImageUrl']),
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover);
        });
  }

  @override
  Widget build(BuildContext context) {
    return _picture();
  }
}
