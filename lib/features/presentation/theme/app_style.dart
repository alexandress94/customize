import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_color.dart';

//Text('qualquer coisa', style: Get.textTheme.headline6);

class AppStyle {
  final TextTheme appTextThemeDark = TextTheme(
    // Estilo do corpo do app.
    bodyText1: _textStyle(
        color: AppDarkColors.appPrimaryColor,
        fontSize: 16.0.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5.sp),
    bodyText2: _textStyle(
        color: AppDarkColors.appPrimaryColor,
        fontSize: 14.0.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25.sp),
    subtitle1: _textStyle(
        color: AppDarkColors.appPrimaryColor,
        fontSize: 16.0.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15.sp),
    subtitle2: _textStyle(
        color: AppDarkColors.appPrimaryColor,
        fontSize: 14.0.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1.sp),
    headline1: _textStyle(
        color: AppDarkColors.appPrimaryColor,
        fontSize: 96.0.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: -1.5.sp),
    headline2: _textStyle(
        color: AppDarkColors.appPrimaryColor,
        fontSize: 60.0.sp,
        fontWeight: FontWeight.w200,
        letterSpacing: -0.5.sp),
    headline3: _textStyle(
        color: AppDarkColors.appPrimaryColor,
        fontSize: 48.0.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.sp),
    headline4: _textStyle(
        color: AppDarkColors.appPrimaryColor,
        fontSize: 34.0.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25.sp),
    headline5: _textStyle(
        color: AppDarkColors.appPrimaryColor,
        fontSize: 24.0.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.18.sp),
    headline6: _textStyle(
        color: AppDarkColors.appPrimaryColor,
        fontSize: 20.0.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15.sp),
    caption: _textStyle(
        color: AppDarkColors.appPrimaryColor,
        fontSize: 12.0.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4.sp),
    overline: _textStyle(
        color: AppDarkColors.appPrimaryColor,
        fontSize: 10.0.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5.sp),
    button: _textStyle(
        color: AppDarkColors.appPrimaryColor,
        fontSize: 14.0.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25.sp),
  );

  final TextTheme appTextThemeLight = TextTheme(
    // Estilo do corpo do app.
    bodyText1: _textStyle(
      fontSize: 16.0.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5.sp,
      color: AppLightColors.appPrimaryColor,
    ),
    bodyText2: _textStyle(
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25.sp,
      color: AppLightColors.appPrimaryColor,
    ),
    subtitle1: _textStyle(
      fontSize: 16.0.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15.sp,
      color: AppLightColors.appPrimaryColor,
    ),
    subtitle2: _textStyle(
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1.sp,
      color: AppLightColors.appPrimaryColor,
    ),
    headline1: _textStyle(
      fontSize: 96.0.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: -1.5.sp,
      color: AppLightColors.appPrimaryColor,
    ),
    headline2: _textStyle(
      fontSize: 60.0.sp,
      fontWeight: FontWeight.w200,
      letterSpacing: -0.5.sp,
      color: AppLightColors.appPrimaryColor,
    ),
    headline3: _textStyle(
      fontSize: 48.0.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.sp,
      color: AppLightColors.appPrimaryColor,
    ),
    headline4: _textStyle(
      fontSize: 34.0.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25.sp,
      color: AppLightColors.appPrimaryColor,
    ),
    headline5: _textStyle(
      fontSize: 24.0.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.18.sp,
      color: AppLightColors.appPrimaryColor,
    ),
    headline6: _textStyle(
      fontSize: 20.0.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15.sp,
      color: AppLightColors.appPrimaryColor,
    ),
    caption: _textStyle(
      fontSize: 12.0.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4.sp,
      color: AppLightColors.appPrimaryColor,
    ),
    overline: _textStyle(
      fontSize: 10.0.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5.sp,
      color: AppLightColors.appPrimaryColor,
    ),
    button: _textStyle(
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25.sp,
      color: AppLightColors.appPrimaryColor,
    ),
  );
}

TextStyle _textStyle({
  required double fontSize,
  required FontWeight fontWeight,
  required double letterSpacing,
  Color? color,
}) {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    letterSpacing: letterSpacing,
  );
}
