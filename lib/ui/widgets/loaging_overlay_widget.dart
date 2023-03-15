import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingOverlayWidget {
  static void hide() {
    Get.back();
  }

  static void show({String? message}) {
    Get.dialog(
      CupertinoAlertDialog(
        title: Row(children: [
          Text(message ?? 'loading...'),
        ]),
        content: const Center(child: CircularProgressIndicator()),
      ),
      barrierDismissible: true,
    );
  }
}
