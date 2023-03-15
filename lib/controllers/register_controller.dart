import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rhitmo_list/controllers/auth_controller.dart';

enum RegisterState { initial, loading, failed, success }

class RegisterController extends GetxController {
  var emailRegister = ''.obs;
  var passwordRegister = ''.obs;
  var confirmPasswordRegister = ''.obs;
  var state = RegisterState.initial.obs;
  var user = Rxn<User>();

  @override
  void onInit() async {
    String? storedEmail = GetStorage().read('email');
    if (storedEmail != null) {
      emailRegister.value = storedEmail;
    }
    String? storedPassword = GetStorage().read('password');
    if (storedPassword != null) {
      passwordRegister.value = storedPassword;
    }
    String? storedConfirmPassword = GetStorage().read('confirmPassword');
    if (storedConfirmPassword != null) {
      confirmPasswordRegister.value = storedConfirmPassword;
    }
    ever(emailRegister, (_) {
      GetStorage().write('email', emailRegister);
    });
    ever(passwordRegister, (_) {
      GetStorage().write('password', passwordRegister);
    });
    ever(confirmPasswordRegister, (_) {
      GetStorage().write('confirmPassword', confirmPasswordRegister);
    });
    super.onInit();
  }

  void clearObs() {
    emailRegister = ''.obs;
    passwordRegister = ''.obs;
    confirmPasswordRegister = ''.obs;
    state = RegisterState.initial.obs;
  }

  void signUp() async {
    try {
      AuthController auth = AuthController();
      state.value = RegisterState.loading;
      user.value =
          await auth.signUp(emailRegister.value, passwordRegister.value);
      state.value = RegisterState.success;
    } on Exception {
      state.value = RegisterState.failed;
      Future.delayed(const Duration(seconds: 1));
      state.value = RegisterState.initial;
    }
  }
}
