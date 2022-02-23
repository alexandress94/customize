import 'package:flutter/material.dart';
import 'app_color.dart';
import 'app_style.dart';

class AppTheme {
  ThemeData appDarkThemeData = ThemeData.dark().copyWith(
    primaryColor: appDarkPrimaryColor,
    primaryColorLight: appDarkPrimaryColor,
    splashColor: appDarkPrimaryColor,
    // Setando a cor padrão do background das páginas.
    scaffoldBackgroundColor: appDarkBackgroundColor,
    // Setando o estilo de texto padrão
    textTheme: AppStyle().appTextThemeDark,
    // Definindo o theme light
    brightness: Brightness.dark,
    // Setando a cor padrão do AppBars
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: appDarkPrimaryColor,
      iconTheme: const IconThemeData(
        color: appDarkBodyColor,
      ),
      titleTextStyle: AppStyle()
          .appTextThemeDark
          .headline6!
          .copyWith(color: appDarkBodyColor),
    ),
    // Setando a cor padrão do ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(appDarkPrimaryColor),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          appDarkPrimaryColor.withOpacity(0.2),
        ),
        // Setando a cor padrão do TextButton
        foregroundColor: MaterialStateProperty.all(appDarkBodyColor),
      ),
    ),
    iconTheme: const IconThemeData(color: appDarkBodyColor),
    inputDecorationTheme: InputDecorationTheme(
      // disabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(10),
      //   borderSide: const BorderSide(
      //       // color: appDarkBodyColor,
      //       ),
      // ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: appDarkBodyColor,
        ),
      ),
      // floatingLabelStyle: const TextStyle(color: appDarkBodyColor),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: appDarkPrimaryColor, width: 2),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    dividerColor: appDarkBodyColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: appDarkPrimaryColor,
      secondary: appDarkPrimaryColor,
    ),
    cardTheme: const CardTheme(
      color: appDarkSecondaryColor,
      elevation: 5.0,
    ),
  );

  ThemeData appLightThemeData = ThemeData.dark().copyWith(
    primaryColor: appLightPrimaryColor,
    primaryColorLight: appLightPrimaryColor,
    splashColor: appLightPrimaryColor,
    // Setando a cor padrão do background das páginas.
    scaffoldBackgroundColor: appLightBackgroundColor,
    // Setando o estilo de texto padrão
    textTheme: AppStyle().appTextThemeLight,
    // Definindo o theme light
    brightness: Brightness.light,
    // Setando a cor padrão do AppBars
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: appLightPrimaryColor,
      iconTheme: const IconThemeData(
        color: appLightBodyColor,
      ),
      titleTextStyle: AppStyle()
          .appTextThemeLight
          .headline6!
          .copyWith(color: appLightBodyColor),
    ),
    // Setando a cor padrão do ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(appLightPrimaryColor),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          appLightPrimaryColor.withOpacity(0.2),
        ),
        // Setando a cor padrão do TextButton
        foregroundColor: MaterialStateProperty.all(appLightBodyColor),
      ),
    ),
    iconTheme: const IconThemeData(color: appLightBodyColor),
    inputDecorationTheme: InputDecorationTheme(
      // disabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(10),
      //   borderSide: const BorderSide(
      //       // color: appLightBodyColor,
      //       ),
      // ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: appLightBodyColor,
        ),
      ),
      // floatingLabelStyle: const TextStyle(color: appLightBodyColor),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: appLightPrimaryColor, width: 2),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    dividerColor: appLightBodyColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: appLightPrimaryColor,
      secondary: appLightPrimaryColor,
    ),
    cardTheme: const CardTheme(
      color: appLightSecondaryColor,
      elevation: 5.0,
    ),
  );
}
