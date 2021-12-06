import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wish_list/pages/home_page.dart';
import 'package:wish_list/pages/text_parameters.dart';

class UserProfilePicture extends StatelessWidget {
  const UserProfilePicture({Key? key}) : super(key: key);
  Widget _userPicture(String url, BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FractionallySizedBox(
          child: CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(url),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
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
          return _userPicture(userDocument?['userImageUrl'], context);
        });
  }
}
