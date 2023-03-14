import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  get user => _firebaseAuth.currentUser;

  Future<User> logIn(String email, String password) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    final user = result.user!;
    return user;
  }

  Future<User> signUp(String email, String password) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = result.user!;
    return user;
  }

  Future signOut() async => await _firebaseAuth.signOut();
}
