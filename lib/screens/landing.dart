import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wish_list/domain/my_user.dart';
import 'package:wish_list/screens/auth.dart';

//mport 'package:wish_list/screens2/auth.dart';

import 'home_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyUser? myUser = Provider.of<MyUser?>(context);
    final bool isLoggedIn = myUser != null;

    return isLoggedIn ? HomePageWidgets() : AuthorizationPage();
  }
}
