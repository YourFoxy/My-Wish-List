import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wish_list/pages/home_page.dart';
import 'package:wish_list/pages/profile_edit_page.dart';
import 'package:wish_list/services/auth.dart';

class UserProfileInformation {
  static Future<void> addUserInformation() {
    return FirebaseFirestore.instance.collection('Users').doc(userUid).set({
      'userNicknameController': userNicknameController.text,
      'userAgeController': userAgeController.text,
      'userCityController': userCityController.text,
      'userImageUrl':
          'https://sun9-11.userapi.com/impg/e3GSKLomqW9aEUnCMPqbeYo7LGY22IhfxwRQVA/rnT3cvaOe18.jpg?size=720x900&quality=96&sign=39226f38b88399db41020b178108ca01&type=album',
    });
  }

  static Future<void> updateUserInformation(String imageUrl) async {
    return FirebaseFirestore.instance.collection('Users').doc(userUid).update({
      'userNicknameController': userNicknameController.text,
      'userAgeController': userAgeController.text,
      'userCityController': userCityController.text,
      'userImageUrl': imageUrl,
    });
  }
}
