// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wish_list/domain/my_user.dart';
import 'package:wish_list/domain/user_profile_information.dart';
import 'package:wish_list/pages/profile_edit_page.dart';
import 'package:wish_list/services/auth.dart';
import 'package:wish_list/translation/locale_keys.g.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

bool showLogin = true;

class _AuthorizationPageState extends State<AuthorizationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late String _email;
  late String _password;

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = const AssetImage('images/foxy%.png');
    Image foxy = Image(image: assetImage);

    Widget _logo() {
      return Padding(
        padding: const EdgeInsets.only(top: 150),
        child: Align(
          child: SizedBox(
            child: foxy,
            height: 100,
          ),
        ),
      );
    }

    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obscure) {
      return Container(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white30),
            hintText: hint,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 3,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white54,
                width: 1,
              ),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: IconTheme(
                data: const IconThemeData(
                  color: Colors.white,
                ),
                child: icon,
              ),
            ),
          ),
        ),
      );
    }

    Widget _button(String text, Function() func) {
      return RaisedButton(
          splashColor: Theme.of(context).primaryColor,
          highlightColor: Theme.of(context).primaryColor,
          color: Colors.white,
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 20),
          ),
          onPressed: () {
            func();

            setState(() {});
          });
    }

    Widget _formRegister(String label, Function() func) {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: _input(const Icon(Icons.email), LocaleKeys.EMAIL.tr(),
                _emailController, false),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _input(const Icon(Icons.lock), LocaleKeys.PASSWORD.tr(),
                _passwordController, true),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _input(const Icon(Icons.person), LocaleKeys.Nickname.tr(),
                userNicknameController, false),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _input(const Icon(Icons.location_city), LocaleKeys.City.tr(),
                userCityController, false),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _input(const Icon(Icons.assignment_ind_sharp),
                LocaleKeys.Age.tr(), userAgeController, false),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: _button(label, func),
            ),
          ),
        ],
      );
    }

    Widget _formLog(String label, Function() func) {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: _input(const Icon(Icons.email), LocaleKeys.EMAIL.tr(),
                _emailController, false),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _input(const Icon(Icons.lock), LocaleKeys.PASSWORD.tr(),
                _passwordController, true),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: _button(label, () => func()),
            ),
          ),
        ],
      );
    }

    void _loginButtonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;

      if (_email.isEmpty || _password.isEmpty) return;

      MyUser? myUser = await _authService.singInWithEmailAndPassword(
          _email.trim(), _password.trim());
      if (myUser == null) {
        Fluttertoast.showToast(
            msg: LocaleKeys.Check_SingIn_email_password.tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        _emailController.clear();
        _passwordController.clear();
      }
    }

    void _registerButtonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;

      if (_email.isEmpty || _password.isEmpty) return;

      MyUser? myUser = await _authService.registerInWithEmailAndPassword(
          _email.trim(), _password.trim());
      if (myUser == null) {
        Fluttertoast.showToast(
            msg: LocaleKeys.Check_Register_email_password,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        UserProfileInformation.addInformation('${userNicknameController.text}',
            '${userAgeController.text}', '${userCityController.text}');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isRu', true);
        _emailController.clear();
        _passwordController.clear();
        userNicknameController.clear();
        userAgeController.clear();
        userCityController.clear();
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _logo(),
            (showLogin
                ? Column(
                    children: <Widget>[
                      _formLog(LocaleKeys.Login.tr(), () {
                        _loginButtonAction();
                      }),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          child: Text(
                            LocaleKeys.Not_registered_yet_Register.tr(),
                            style: TextStyle(
                                fontSize: Localizations.localeOf(context)
                                            .toLanguageTag() ==
                                        'ru'
                                    ? 14
                                    : 20,
                                color: Colors.white),
                          ),
                          onTap: () {
                            setState(() {
                              showLogin = false;
                            });
                          },
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: <Widget>[
                      _formRegister(
                          LocaleKeys.REGISTER.tr(), _registerButtonAction),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          child: Text(
                            LocaleKeys.Already_registered_Login.tr(),
                            style: TextStyle(
                                fontSize: Localizations.localeOf(context)
                                            .toLanguageTag() ==
                                        'ru'
                                    ? 14
                                    : 20,
                                color: Colors.white),
                          ),
                          onTap: () {
                            setState(() {
                              showLogin = true;
                            });
                          },
                        ),
                      ),
                    ],
                  )),
          ],
        ),
      ),
    );
  }
}
