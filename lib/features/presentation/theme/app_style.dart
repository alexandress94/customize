import 'package:flutter/material.dart';
import 'app_color.dart';

//Text('qualquer coisa', style: Get.textTheme.headline6);

class AppStyle {
  final TextTheme appTextThemeDark = TextTheme(
    // Estilo do corpo do app.
    bodyText1: _textStyle(
        fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: _textStyle(
        fontSize: 14.0, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    subtitle1: _textStyle(
        fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: _textStyle(
        fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    headline1: _textStyle(
        fontSize: 96.0, fontWeight: FontWeight.w400, letterSpacing: -1.5),
    headline2: _textStyle(
        fontSize: 60.0, fontWeight: FontWeight.w200, letterSpacing: -0.5),
    headline3: _textStyle(
        fontSize: 48.0, fontWeight: FontWeight.w400, letterSpacing: 0),
    headline4: _textStyle(
        fontSize: 34.0, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5: _textStyle(
        fontSize: 24.0, fontWeight: FontWeight.w400, letterSpacing: 0.18),
    headline6: _textStyle(
        fontSize: 20.0, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    caption: _textStyle(
        fontSize: 12.0, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: _textStyle(
        fontSize: 10.0, fontWeight: FontWeight.w400, letterSpacing: 1.5),
    button: _textStyle(
        fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  );

  final TextTheme appTextThemeLight = TextTheme(
    // Estilo do corpo do app.
    bodyText1: _textStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: appLightBodyColor,
    ),
    bodyText2: _textStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: appLightBodyColor,
    ),
    subtitle1: _textStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: appLightBodyColor,
    ),
    subtitle2: _textStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: appLightBodyColor,
    ),
    headline1: _textStyle(
      fontSize: 96.0,
      fontWeight: FontWeight.w400,
      letterSpacing: -1.5,
      color: appLightBodyColor,
    ),
    headline2: _textStyle(
      fontSize: 60.0,
      fontWeight: FontWeight.w200,
      letterSpacing: -0.5,
      color: appLightBodyColor,
    ),
    headline3: _textStyle(
      fontSize: 48.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: appLightBodyColor,
    ),
    headline4: _textStyle(
      fontSize: 34.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: appLightBodyColor,
    ),
    headline5: _textStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.18,
      color: appLightBodyColor,
    ),
    headline6: _textStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: appLightBodyColor,
    ),
    caption: _textStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: appLightBodyColor,
    ),
    overline: _textStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: appLightBodyColor,
    ),
    button: _textStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      color: appLightBodyColor,
    ),
  );
}

TextStyle _textStyle({
  required double fontSize,
  required FontWeight fontWeight,
  required double letterSpacing,
  Color? color = appDarkBodyColor,
}) {
  return TextStyle(
    fontFamily: 'Roboto',
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    letterSpacing: letterSpacing,
  );
}
