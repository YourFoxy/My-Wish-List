import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wish_list/pages/home_page.dart';
import 'package:wish_list/pages/text_parameters.dart';
import 'package:wish_list/services/auth.dart';
import 'package:wish_list/widgets/search_bar.dart';
import 'package:wish_list/widgets/user.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);
  Widget _friendsView() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(userUid)
            .doc('data')
            .collection('Friends')
            //.where('userNicknameController', isGreaterThanOrEqualTo: 'A').
            .snapshots()
            .asBroadcastStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null) {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ));
          }
          return ListView(
              shrinkWrap: true,
              children: snapshot.data!.docs.map((user) {
                Map<String, dynamic> data = user.data() as Map<String, dynamic>;

                return _buildUser(context, data['friend']);
              }).toList());
        });
  }

  Widget _buildUser(BuildContext context, String uid) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('Users').doc(uid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const TextParameters(text: '', fontSize: 20.0);
          }
          var userDocument = snapshot.data;
          return User(
            name: userDocument!['userNicknameController'],
            urlImage: userDocument['userImageUrl'],
            uid: uid,
            isAdd: false,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _friendsView(),
    );
  }
}
