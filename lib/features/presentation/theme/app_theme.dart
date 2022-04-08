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

  ThemeData appLightThemeData = ThemeData.light().copyWith(
    unselectedWidgetColor: AppLightColors.appSecondaryColor,
    toggleableActiveColor: AppLightColors.appBlackColor,
    primaryColor: AppLightColors.appPrimaryColor,
    primaryColorLight: AppLightColors.appPrimaryColor,
    splashColor: AppLightColors.appPrimaryColor,
    // Setando a cor padrão do background das páginas.
    scaffoldBackgroundColor: AppLightColors.appPrimaryBackgroundColor,
    // Setando o estilo de texto padrão
    textTheme: AppStyle().appTextThemeLight,
    // Definindo o theme light
    brightness: Brightness.light,
    // Setando a cor padrão do AppBars
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: AppLightColors.appWhiteColor,
      iconTheme: const IconThemeData(
        color: AppLightColors.appBlackColor,
      ),
      titleTextStyle: AppStyle().appTextThemeLight.headline6!.copyWith(
            color: AppLightColors.appPrimaryColor,
          ),
    ),
    // Setando a cor padrão do ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(AppLightColors.appBlackColor),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          AppLightColors.appPrimaryColor.withOpacity(0.2),
        ),
        // Setando a cor padrão do TextButton
        foregroundColor:
            MaterialStateProperty.all(AppLightColors.appPrimaryColor),
      ),
    ),
    iconTheme: const IconThemeData(color: AppLightColors.appPrimaryColor),
    inputDecorationTheme: InputDecorationTheme(
      // custom background color
      fillColor: AppLightColors.appWhiteColor,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppLightColors.appWhiteColor,
        ),
      ),
      hintStyle: const TextStyle(
        color: AppLightColors.appSecondaryColor,
      ),
      // floatingLabelStyle: const TextStyle(color: appLightBodyColor),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppLightColors.appIconGrayColor,
          width: 2,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    dividerColor: AppLightColors.appIconGrayColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppLightColors.appIconGrayColor,
      secondary: AppLightColors.appIconGrayColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppLightColors.appBlackColor,
    ),
    cardTheme: const CardTheme(
      color: AppLightColors.appSecondaryColor,
      elevation: 5.0,
    ),
  );
}
