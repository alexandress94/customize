import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class CheckNativeDarkmodeServiceController extends GetxController {
  bool isDarkMode = false;

  @override
  void onInit() {
    var brightness = SchedulerBinding.instance!.window.platformBrightness;
    isDarkMode = brightness == Brightness.dark;
    super.onInit();
  }
}
