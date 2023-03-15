import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rhitmo_list/controllers/auth_controller.dart';

class LoginController extends GetxController {
  var emailLogin = ''.obs;
  var passwordLogin = ''.obs;
  var user = Rxn<User>();

  @override
  void onInit() async {
    String? storedEmail = GetStorage().read('email');
    if (storedEmail != null) {
      emailLogin.value = storedEmail;
    }
    String? storedPassword = GetStorage().read('password');
    if (storedPassword != null) {
      passwordLogin.value = storedPassword;
    }
    ever(emailLogin, (_) {
      GetStorage().write('email', emailLogin);
    });
    ever(passwordLogin, (_) {
      GetStorage().write('password', passwordLogin);
    });
    super.onInit();
  }

  void clearObs() {
    emailLogin = ''.obs;
    passwordLogin = ''.obs;
  }

  Future<void> logIn() async {
    try {
      AuthController auth = AuthController();
      user.value = await auth.logIn(emailLogin.value, passwordLogin.value);
    } on Exception {
      throw Exception();
    }
  }
}
