import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wish_list/screens/adding_gifts.dart';
import 'package:wish_list/screens/home_page.dart';
import 'package:wish_list/screens/text_parameters.dart';
import 'package:wish_list/services/auth.dart';
import 'package:wish_list/widgets/profile_info_edit_widget.dart';
import 'package:wish_list/widgets/save_button_widget.dart';

import 'my_container.dart';

final TextEditingController userFirstNameController = TextEditingController();
final TextEditingController userSecondNameController = TextEditingController();
final TextEditingController userAgeController = TextEditingController();
final TextEditingController userCityController = TextEditingController();

class SetDataProfileWidget extends StatefulWidget {
  SetDataProfileWidget({Key? key}) : super(key: key);

  @override
  _SetDataProfileWidgetState createState() => _SetDataProfileWidgetState();
}

class _SetDataProfileWidgetState extends State<SetDataProfileWidget> {
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
          const SingleChildScrollView(
            child: ProfileInfoEditWidget(),
          ),
          SaveButtonWidget(func: () {
            AddUserInformation.updateUserInformation();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePageWidgets()),
            );
          })
        ],
      ),
    );
  }
}

// class AddGift {
//   //final String nameOfGift;
//   //final String description;
//   final bool isShow = false;
//   //final bool = false;
//   // AddGift({required this.nameOfGift, required this.description});

//   Future<void> addGift() {
//     return FirebaseFirestore.instance
//         .collection('Users')
//         .doc(fAuth.currentUser!.uid)
//         .collection('profile information')
//         .add({
//       'userFirstNameController': userFirstNameController.text,
//       'userSecondNameController': userSecondNameController.text,
//       'userAgeController': userAgeController.text,
//       'userCityController': userCityController.text
//     });
//   }
// }
class AddUserInformation {
  static Future<void> addUserInformation() {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(fAuth.currentUser!.uid)
        .collection('profile information')
        .doc('info')
        .set({
      'userFirstNameController': userFirstNameController.text,
      'userSecondNameController': userSecondNameController.text,
      'userAgeController': userAgeController.text,
      'userCityController': userCityController.text
    });
  }

  static Future<void> updateUserInformation() {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(fAuth.currentUser!.uid)
        .collection('profile information')
        .doc('info')
        .update({
      'userFirstNameController': userFirstNameController.text,
      'userSecondNameController': userSecondNameController.text,
      'userAgeController': userAgeController.text,
      'userCityController': userCityController.text
    });
  }
}
