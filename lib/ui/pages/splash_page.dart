import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhitmo_list/ui/pages/home_page.dart';
import 'package:rhitmo_list/ui/pages/login_page.dart';

import '../../controllers/auth_controller.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  final AuthController authController = Get.put(AuthController());
  static const id = '/splash_page';

  @override
  Widget build(BuildContext context) {
    startTime();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/images/rhitmo.jpeg',
            height: 300.0,
            width: 300.0,
          ),
        ),
      ),
    );
  }

  startTime() async {
    return Timer(const Duration(seconds: 2), () async {
      authController.isLogged!
          ? Get.offNamed(HomePage.id)
          : Get.offNamed(LoginPage.id);
      return;
    });
  }
}
