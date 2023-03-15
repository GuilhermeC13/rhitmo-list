import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  get user => _firebaseAuth.currentUser;
  final box = GetStorage();
  bool? get isLogged => box.read('token') ?? false;

  Future<User> logIn(String email, String password) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    final user = result.user!;
    saveToken(await user.getIdToken());
    return user;
  }

  Future<User> signUp(String email, String password) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = result.user!;
    return user;
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
  }

  void saveToken(String val) => box.write('token', val);
}
