import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Myrw extends StatefulWidget {
  Myrw({Key? key}) : super(key: key);

  @override
  _MyrwState createState() => _MyrwState();
}

class _MyrwState extends State<Myrw> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          FirebaseFirestore.instance
              .collection('users')
              .doc()
              .collection('uid')
              .add({
            'name': 'dddd',
            'age': '23',
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Container(),
    );
  }
}
