import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rhitmo_list/controllers/auth_controller.dart';
import 'package:rhitmo_list/controllers/database_provider.dart';

import '../models/todo.dart';

enum RegisterState { initial, loading, failed, success }

class RegisterController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var state = RegisterState.initial.obs;
  var user = Rxn<User>();

  @override
  void onInit() async {
    email = GetStorage().read('email');
    password = GetStorage().read('password');
    confirmPassword = GetStorage().read('confirmPassword');
    ever(email, (_) {
      GetStorage().write('email', email);
    });
    ever(password, (_) {
      GetStorage().write('password', password);
    });
    ever(confirmPassword, (_) {
      GetStorage().write('confirmPassword', confirmPassword);
    });
    super.onInit();
  }

  void clearObs() {
    email = ''.obs;
    password = ''.obs;
    confirmPassword = ''.obs;
  }

  void signUp() async {
    try {
      AuthController auth = AuthController();
      state.value = RegisterState.loading;
      user.value = await auth.signUp(email.value, password.value);
      state.value = RegisterState.success;
    } on Exception {
      state.value = RegisterState.failed;
    }
  }
}
