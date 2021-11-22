import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:wish_list/domain/user_profile_information.dart';
import 'package:wish_list/pages/home_page.dart';
import 'package:wish_list/services/auth.dart';
import 'package:wish_list/widgets/place_for_picture.dart';
import 'package:wish_list/widgets/save_button_widget.dart';
import 'package:wish_list/widgets/text_field.dart';

final TextEditingController userFirstNameController = TextEditingController();
final TextEditingController userSecondNameController = TextEditingController();
final TextEditingController userAgeController = TextEditingController();
final TextEditingController userCityController = TextEditingController();

List dataList = [];
//late Image media = Image(image: NetworkImage(''));
late String imageUrl = '';

class SetDataProfileWidget extends StatefulWidget {
  SetDataProfileWidget({Key? key}) : super(key: key);

  @override
  _SetDataProfileWidgetState createState() => _SetDataProfileWidgetState();
}

class _SetDataProfileWidgetState extends State<SetDataProfileWidget> {
  Widget _profileInfoEdit() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          PlaceForPictureWidget(),
          TextFieldWidget(
            fieldName: 'first name',
            controller: userFirstNameController,
            maxLength: 20,
            maxLines: 1,
          ),
          TextFieldWidget(
            fieldName: 'second name',
            controller: userSecondNameController,
            maxLength: 20,
            maxLines: 1,
          ),
          TextFieldWidget(
            fieldName: 'age',
            controller: userAgeController,
            maxLength: 20,
            maxLines: 1,
          ),
          TextFieldWidget(
            fieldName: 'city',
            controller: userCityController,
            maxLength: 20,
            maxLines: 1,
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget _saveData() {
    return SaveButtonWidget(func: () async {
      imageProfileFile != null
          ? await FirebaseStorage.instance
              .ref()
              .child("users/${fAuth.currentUser!.uid}")
              .putFile(imageProfileFile!)
          : null;
      var str = await FirebaseStorage.instance
          .ref("users/${fAuth.currentUser!.uid}")
          .getDownloadURL();

      UserProfileInformation.updateUserInformation(str);
      imageProfileFile = null;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePageWidgets()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePageWidgets()),
          ),
        ),
        title: const Text(''),
        // actions: _appBarMenuWidget(Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        children: <Widget>[
          _profileInfoEdit(),
          _saveData(),
        ],
      ),
    );
  }
}