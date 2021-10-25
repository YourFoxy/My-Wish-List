import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wish_list/domain/my_user.dart';
import 'package:wish_list/services/auth.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late String _email;
  late String _password;
  bool showLogin = true;

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = const AssetImage('images/foxy%.png');
    //Image foxy = Image(image: assetImage);

    // Widget _logo() {
    //   return Padding(
    //     padding: const EdgeInsets.only(top: 150),
    //     child: Align(
    //       child: SizedBox(
    //         child: foxy,
    //         height: 100,
    //       ),
    //     ),
    //   );
    // }

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
      // ignore: deprecated_member_use
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
          });
      //onPressed: onPressed)
    }

    Widget _form(String label, Function() func) {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: _input(
                const Icon(Icons.email), 'EMAIL', _emailController, false),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _input(
                const Icon(Icons.lock), 'PASSWORD', _passwordController, true),
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

    void _loginButtonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;

      if (_email.isEmpty || _password.isEmpty) return;

      MyUser? myUser = await _authService.singInWithEmailAndPassword(
          _email.trim(), _password.trim());
      if (myUser == null) {
        Fluttertoast.showToast(
            msg: "Can't SignIn you! Please check your email/password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            //timeInSecForIosWeb: 1,
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
            msg: "Can't Register you! Please check your email/password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            //timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        _emailController.clear();
        _passwordController.clear();
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //_logo(),
            (showLogin
                ? Column(
                    children: <Widget>[
                      _form('Login', _loginButtonAction),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          child: const Text(
                            'Not registered yet? Register!',
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
                      _form('REGISTER', _registerButtonAction),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          child: const Text(
                            'Already registered? Login!',
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
