import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wish_list/domain/my_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:wish_list/pages/home_page.dart';
import 'package:wish_list/pages/landing.dart';
import 'package:wish_list/services/auth.dart';
import 'package:wish_list/translation/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('ru'),
      ],
      path: 'translation', // <-- change the path of the translation files
      fallbackLocale: Locale('ru'),
      assetLoader: CodegenLoader(), child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().currentUser,
      initialData: null,
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Wish List',
        theme: ThemeData(
            primaryColor: const Color(0xFF7B938C),
            textTheme:
                const TextTheme(subtitle1: TextStyle(color: Colors.white))),
        home: const LandingPage(),
      ),
    );
  }
}
