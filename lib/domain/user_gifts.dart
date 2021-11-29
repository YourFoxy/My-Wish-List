import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wish_list/pages/home_page.dart';
import 'package:wish_list/services/auth.dart';

class AddGift {
  final bool isShow = false;

  Future<void> addGift(
    String nameOfGift,
    String description,
    String mediaUrl,
    bool isImage,
  ) {
    return FirebaseFirestore.instance
        .collection(userUid)
        .doc('data')
        .collection('Categories')
        .doc(categoryUid)
        .collection('Gifts')
        .add({
      'nameOfGift': nameOfGift,
      'description': description,
      'isShow': isShow,
      'mediaUrl': mediaUrl,
      'isImage': isImage,
    });
  }
}
