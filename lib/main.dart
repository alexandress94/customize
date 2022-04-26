import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organize_more/core/services/bindings/initial_bindings.dart';
import 'package:organize_more/features/presentation/routes/routes.dart';
import 'core/services/service_controller/theme_service_controller.dart';
import 'features/presentation/routes/app_pages.dart';
import 'features/presentation/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  return runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => GetMaterialApp(
        title: 'Customize',
        locale: const Locale('pt', 'BR'),
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('pt', 'BR'),
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
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
