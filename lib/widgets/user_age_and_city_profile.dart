import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:wish_list/pages/home_page.dart';
import 'package:wish_list/pages/text_parameters.dart';
import 'package:wish_list/translation/locale_keys.g.dart';

class UserProfileAgeAndCity extends StatelessWidget {
  const UserProfileAgeAndCity({Key? key}) : super(key: key);
  Widget _userInfofmation(String age, String city) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextParameters(
            text: age,
            fontSize: 20.0,
          ),
          TextParameters(
            text: city,
            fontSize: 20.0,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('Users').doc(userUid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const TextParameters(text: '', fontSize: 20.0);
          }
          var userDocument = snapshot.data;
          return _userInfofmation(
              '${LocaleKeys.Age.tr()}: ${userDocument?['userAgeController']}',
              '${LocaleKeys.City.tr()}: ${userDocument?['userCityController']}');
        });
  }
}
