import 'dart:convert';

import 'package:avatar_view/avatar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wish_list/pages/home_page.dart';
import 'package:wish_list/pages/text_parameters.dart';
import 'package:wish_list/services/auth.dart';
import 'package:wish_list/widgets/user_picture.dart';

class User extends StatelessWidget {
  String name;
  String urlImage;
  String uid;

  User({
    Key? key,
    required this.name,
    required this.urlImage,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: InkWell(
          onTap: () {
            userUid = uid;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePageWidgets()),
            );
          },
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD1CF),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                children: [
                  UserPicture(
                    urlImage: urlImage,
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                          child: TextParameters(text: name, fontSize: 25.0)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        onPressed: () async {
                          if (await isDuplicateUniqueName(uid)) {
                            print('error');
                          } else {
                            FirebaseFirestore.instance
                                .collection(fAuth.currentUser!.uid)
                                .doc('data')
                                .collection('Friends')
                                .add({'friend': uid});
                          }
                        },
                        icon: const Icon(
                          Icons.person_add,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> isDuplicateUniqueName(String uniqueName) async {
  QuerySnapshot query = await FirebaseFirestore.instance
      .collection(fAuth.currentUser!.uid)
      .doc('data')
      .collection('Friends')
      .where('friend', isEqualTo: uniqueName)
      .get();
  return query.docs.isNotEmpty;
}
