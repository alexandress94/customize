import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:organize_more/core/services/packages/contracts/local_get_storage.dart';
import 'package:organize_more/core/values/keys/keys.dart';

import '../../../routes/routes.dart';

class SplashController extends GetxController {
  final LocalGetStorage _storage;
  RxBool isDarkMode = false.obs;

  SplashController({required LocalGetStorage storage}) : _storage = storage;

  @override
  void onInit() {
    var brightness = SchedulerBinding.instance!.window.platformBrightness;
    isDarkMode.value = brightness == Brightness.dark;
    super.onInit();
  }

  @override
  void onReady() {
    Future.delayed(
      Duration(seconds: 3),
      () async {
        if (await _storage.read(Keys.DISPLAY_ONBOARDING) ?? true) {
          return Get.offAllNamed(Routes.ONBOARDING_PAGE);
        } else {
          return Get.offAllNamed(Routes.TRANSACTION_PAGE);
        }
      },
    );
    super.onReady();
  }
}
