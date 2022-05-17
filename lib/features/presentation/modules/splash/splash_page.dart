import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:customize/features/presentation/modules/splash/controller/splash_controller.dart';
import 'package:customize/features/presentation/theme/app_color.dart';
import 'package:customize/features/presentation/utils/path_logo.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.service.isDarkMode
          ? AppDarkColors.appPrimeryBackgroundColor
          : AppLightColors.appBarBackgroundColor,
      body: Center(
        child: Image.asset(
          controller.service.isDarkMode
              ? PathLogo.LOGO_DARK
              : PathLogo.LOGO_LIGHT,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
