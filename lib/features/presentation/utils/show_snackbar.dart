// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum StatusNotification {
  ERROR,
  SUCCESS,
  WARNING,
  LOADING,
  NOT_FOUND,
}

void showSnackBar({
  required StatusNotification resopnse,
  required String message,
}) {
  // Response resopnse = Response.SUCCESS;
  switch (resopnse) {
    case StatusNotification.ERROR:
      Get.snackbar(
        "Erro.",
        message,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.red,
      );
      break;
    case StatusNotification.SUCCESS:
      Get.snackbar(
        "Finalizado.",
        message,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.green,
      );
      break;
    case StatusNotification.WARNING:
      Get.snackbar(
        "Atenção.",
        message,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.yellow[800],
      );
      break;
    default:
  }
}
