import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organize_more/features/presentation/modules/splash/controller/splash_controller.dart';
import 'package:organize_more/features/presentation/theme/app_color.dart';
import 'package:organize_more/features/presentation/utils/path_logo.dart';

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
          PathLogo.LOGO,
          width: 150.0.w,
          height: 150.0.h,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
