import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organize_more/features/presentation/utils/path_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
