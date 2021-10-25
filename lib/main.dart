import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wish_list/domain/my_user.dart';
import 'package:wish_list/screens/auth.dart';
import 'package:wish_list/screens/landing.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:wish_list/services/auth.dart';
import 'package:flutter/widgets.dart';
import 'package:wish_list/services/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SharedPreferences.setMockInitialValues({});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().currentUser,
      initialData: null,
      child: MaterialApp(
        title: 'Wish List',
        theme: ThemeData(
            //  textTheme: GoogleFonts.latoTextTheme(
            //   Theme.of(context).textTheme,
            // ),
            primaryColor: const Color(0xFF7B938C),
            textTheme:
                const TextTheme(subtitle1: TextStyle(color: Colors.white))),
        home: const LandingPage(),
      ),
    );
  }
}
