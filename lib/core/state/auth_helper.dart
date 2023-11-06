import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> signUp(String email, String password) async {
    UserCredential authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = authResult.user;
    return user?.uid;
  }

  Future<List<String>?> login(String email, String password) async {
    try {
      UserCredential authResult = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      // not used but ok
      User? user = authResult.user;
      return [email, password];
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String?> getUser() async {
    User? user = await _firebaseAuth.currentUser;
    return user?.email;
  }

  Future<String?> logout() async {
    try {
      await _firebaseAuth.signOut();
      return 'done logout';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
