import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wish_list/services/auth.dart';
import 'package:wish_list/widgets/search_bar.dart';
import 'package:wish_list/widgets/user.dart';

class UserSearch extends StatefulWidget {
  UserSearch({Key? key}) : super(key: key);

  @override
  _UserSearchState createState() => _UserSearchState();
}

final nicknameController = TextEditingController();

class _UserSearchState extends State<UserSearch> {
  String _searchUser = '';
  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    nicknameController.addListener(_handleChange);
  }

  void _handleChange() {
    setState(() {
      _searchUser = nicknameController.text;
    });
  }

  Widget _userSearch() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
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
          if (_searchUser.toLowerCase() != '') {
            return ListView(
                shrinkWrap: true,
                children: snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) =>
                        element['userNicknameController']
                            .toString()
                            .toLowerCase()
                            .contains('${_searchUser}'.toLowerCase()))
                    .map((user) {
                  Map<String, dynamic> data =
                      user.data() as Map<String, dynamic>;

                  return User(
                    name: '${data['userNicknameController']}',
                    urlImage: '${data['userImageUrl']}',
                    uid: user.id,
                    isAdd: true,
                  );
                }).toList());
          } else {
            return SizedBox();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SearchBarWidget(),
            _userSearch(),
          ],
        ),
      ),
    );
  }
}
