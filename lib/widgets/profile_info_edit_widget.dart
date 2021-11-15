import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wish_list/screens/editing_profile.dart';
import 'dart:io';

class ProfileInfoEditWidget extends StatefulWidget {
  const ProfileInfoEditWidget({Key? key}) : super(key: key);

  @override
  _ProfileInfoEditWidgetState createState() => _ProfileInfoEditWidgetState();
}

class _ProfileInfoEditWidgetState extends State<ProfileInfoEditWidget> {
  Widget _spaceForMedia() {
    return InkWell(
      onTap: () async {
        print('object');
        var image = await ImagePicker().pickImage(source: ImageSource.gallery);
        File file = File(image!.path);
        var storage = FirebaseStorage.instance;
        TaskSnapshot snapshot =
            await storage.ref().child("images/k").putFile(file);
      },
      child: Container(
        width: double.infinity,
        height: 300,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget cont(String str, TextInputType textInputType,
      TextEditingController _controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: TextField(
        //if(number) =>  keyboardType: TextInputType.number,
        keyboardType: textInputType,
        controller: _controller,
        maxLength: 20,
        cursorColor: Theme.of(context).primaryColor,
        style: GoogleFonts.crimsonText(
          color: Theme.of(context).primaryColor,
          //textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Theme.of(context).primaryColor,
          ),
          //fillColor: Colors.amber,
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
        _spaceForMedia(),
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
