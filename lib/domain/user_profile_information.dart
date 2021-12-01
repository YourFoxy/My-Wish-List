import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wish_list/pages/profile_edit_page.dart';
import 'package:wish_list/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileInformation {
  static Future<void> addUserInformation() {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(fAuth.currentUser!.uid)
        .set({
      'userNicknameController': userNicknameController.text,
      'userAgeController': userAgeController.text,
      'userCityController': userCityController.text,
      'userImageUrl':
          'https://sun9-11.userapi.com/impg/e3GSKLomqW9aEUnCMPqbeYo7LGY22IhfxwRQVA/rnT3cvaOe18.jpg?size=720x900&quality=96&sign=39226f38b88399db41020b178108ca01&type=album',
    });
  }

  static void addInformation(String name, String age, String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('${fAuth.currentUser!.uid} Nickname', name);
    prefs.setString('${fAuth.currentUser!.uid} Age', age);
    prefs.setString('${fAuth.currentUser!.uid} City', city);

    addUserInformation();
  }

  static void updateInformation(
      String name, String age, String city, String imageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('${fAuth.currentUser!.uid} Nickname', name);
    prefs.setString('${fAuth.currentUser!.uid} Age', age);
    prefs.setString('${fAuth.currentUser!.uid} City', city);
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(fAuth.currentUser!.uid)
        .update({
      'userNicknameController': userNicknameController.text,
      'userAgeController': userAgeController.text,
      'userCityController': userCityController.text,
    });

    imageUrl != ''
        ? await FirebaseFirestore.instance
            .collection('Users')
            .doc(fAuth.currentUser!.uid)
            .update({
            'userImageUrl': imageUrl,
          })
        : null;
  }
}
