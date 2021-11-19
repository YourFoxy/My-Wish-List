import 'package:avatar_view/avatar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wish_list/screens/editing_profile.dart';
import 'package:wish_list/screens/text_parameters.dart';
import 'dart:io';

import 'package:wish_list/services/auth.dart';
import 'package:wish_list/widgets/place_for_picture.dart';

class ProfileInfoEditWidget extends StatefulWidget {
  const ProfileInfoEditWidget({Key? key}) : super(key: key);

  @override
  _ProfileInfoEditWidgetState createState() => _ProfileInfoEditWidgetState();
}

File? file;

class _ProfileInfoEditWidgetState extends State<ProfileInfoEditWidget> {
  File? image;
  String? imageURL;
  Widget _spaceForMedia() {
    return Container(
      height: 300,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: InkWell(
        onTap: () async {
          var image =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (image == null) return;
          file = File(image.path);
          print('FILE ${image.path}');

          setState(() {
            this.image = file;
            imageURL = image.path;
          });
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
            .collection('profile information')
            .doc('info')
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

  Widget cont(String str, TextInputType textInputType,
      TextEditingController _controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: TextField(
        keyboardType: textInputType,
        controller: _controller,
        maxLength: 20,
        cursorColor: Theme.of(context).primaryColor,
        style: GoogleFonts.crimsonText(
          color: Theme.of(context).primaryColor,
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Theme.of(context).primaryColor,
          ),
          labelText: str,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 3,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PlaceForPictureWidget(),
        cont('first name', TextInputType.name, userFirstNameController),
        cont('second name', TextInputType.name, userSecondNameController),
        cont('age', TextInputType.number, userAgeController),
        cont('city', TextInputType.name, userCityController),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}
