import 'package:firebase_auth/firebase_auth.dart';
import 'package:wish_list/domain/my_user.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<MyUser?> singInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
//FirebaseAuth.
      User? user = result.user;
      return MyUser.fromFirebase(user!);
    } catch (e) {
      return null;
    }
  }

  Future<MyUser?> registerInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      return MyUser.fromFirebase(user!);
    } catch (e) {
      return null;
    }
  }

  Future logOut() async {
    await _fAuth.signOut();
  }

  Stream<MyUser?> get currentUser {
    return _fAuth
        .authStateChanges()
        .map((User? user) => user != null ? MyUser.fromFirebase(user) : null);
  }
}
