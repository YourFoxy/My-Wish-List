import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wish_list/screens/auth.dart';
import 'package:wish_list/screens/editing_profile.dart';
import 'package:wish_list/screens/home_page.dart';
import 'package:wish_list/services/auth.dart';
import 'package:wish_list/widgets/profile_info_edit_widget.dart';
import 'package:wish_list/widgets/save_button_widget.dart';

class DataFillingWidget extends StatelessWidget {
  const DataFillingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePageWidgets()),
          ),
        ),
        title: const Text(''),
        // actions: _appBarMenuWidget(Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        children: <Widget>[
          const SingleChildScrollView(
            child: ProfileInfoEditWidget(),
          ),
          SaveButtonWidget(
              func: () => () {
                    AddUserInformation.addUserInformation();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePageWidgets()),
                    );
                    showLogin = false;
                  })
        ],
      ),
    );
  }
}
