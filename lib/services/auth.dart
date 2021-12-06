import 'package:firebase_auth/firebase_auth.dart';
import 'package:wish_list/domain/my_user.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
late String currentUserUid = '';

class AuthService {
  Future<MyUser?> singInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await fAuth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;

      return MyUser.fromFirebase(user!);
    } catch (e) {
      return null;
    }
  }

  Future<MyUser?> registerInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await fAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      return MyUser.fromFirebase(user!);
    } catch (e) {
      return null;
    }
  }

  Future logOut() async {
    await FirebaseAuth.instance.signOut();
    //await fAuth.signOut();
  }

  Stream<MyUser?> get currentUser {
    return fAuth
        .authStateChanges()
        .map((User? user) => user != null ? MyUser.fromFirebase(user) : null);
  }
}
