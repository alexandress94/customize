import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organize_more/core/services/bindings/initial_bindings.dart';
import 'package:organize_more/features/presentation/routes/routes.dart';
import 'features/presentation/routes/app_pages.dart';
import 'features/presentation/theme/app_theme.dart';

void main() async {
  await GetStorage.init();
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  // statusBarColor: appDarkBackgroundColor,
  // statusBarColor: appLightBackgroundColor,
  // ));
  return runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => GetMaterialApp(
        // locale: const Locale('pt', 'BR'),
        // supportedLocales: const [
        //   Locale('en', 'US'),
        //   Locale('pt', 'BR'),
        // ],
        // localizationsDelegates: const [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        // ],
        initialRoute: Routes.INITIAL_PAGE,
        getPages: AppPages.routes,
        initialBinding: InitialBindings(),
        theme: AppTheme().appLightThemeData,
      ),
    ),
  );
}
