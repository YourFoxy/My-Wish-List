import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wish_list/pages/home_page.dart';
import 'package:wish_list/services/auth.dart';

class AddGift {
  final bool isShow = false;

  Future<void> addGift(String nameOfGift, String description, String imageUrl) {
    return FirebaseFirestore.instance
        .collection(fAuth.currentUser!.uid)
        .doc('data')
        .collection('Categories')
        .doc(categoryUid)
        .collection('Gifts')
        .doc('gift')
        .set({
      'nameOfGift': nameOfGift,
      'description': description,
      'isShow': isShow,
      'imageUrl': imageUrl,
    });
  }
}
