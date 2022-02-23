import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:organize_more/core/services/bindings/initial_bindings.dart';
import 'package:organize_more/features/presentation/routes/routes.dart';
import 'features/presentation/routes/app_pages.dart';
import 'features/presentation/theme/app_color.dart';
import 'features/presentation/theme/app_theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: appDarkBackgroundColor,
    // statusBarColor: appLightBackgroundColor,
  ));
  runApp(
    GetMaterialApp(
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      initialRoute: Routes.INITIAL_PAGE,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBindings(),
      theme: AppTheme().appDarkThemeData,
    ),
  );
}
