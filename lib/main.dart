import 'package:customize/core/services/bindings/initial_bindings.dart';
import 'core/services/service_controller/theme_service_controller.dart';
import 'package:customize/features/presentation/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/presentation/routes/app_pages.dart';
import 'features/presentation/theme/app_theme.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  return runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_) => GetMaterialApp(
        title: 'Customize',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
        locale: const Locale('pt', 'BR'),
        initialRoute: Routes.INITIAL_PAGE,
        getPages: AppPages.routes,
        initialBinding: InitialBindings(),
        theme: AppTheme().appLightThemeData,
        darkTheme: AppTheme().appDarkThemeData,
        themeMode: ThemeServiceController().getThemeMode(),
      ),
    ),
  );
}
