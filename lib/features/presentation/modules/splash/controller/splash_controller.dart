import 'package:customize/core/services/local_notification/local_notification_service.dart';
import 'package:get/get.dart';
import 'package:customize/core/services/packages/contracts/local_get_storage.dart';
import 'package:customize/core/services/service_controller/check_native_darkmode_service_controller.dart';
import 'package:customize/core/values/keys/keys.dart';

import '../../../routes/routes.dart';

class SplashController extends GetxController {
  final LocalGetStorage _storage;
  final CheckNativeDarkmodeServiceController _service;
  final LocalNotificationService _notificationService;

  SplashController({
    required LocalGetStorage storage,
    required CheckNativeDarkmodeServiceController service,
    required LocalNotificationService notificationService,
  })  : _storage = storage,
        _notificationService = notificationService,
        _service = service;

  CheckNativeDarkmodeServiceController get service => _service;

  @override
  void onReady() async {
    Future.delayed(
      Duration(seconds: 3),
      () async {
        if (await _storage.read(Keys.DISPLAY_ONBOARDING) ?? true) {
          return Get.offAllNamed(Routes.ONBOARDING_PAGE);
        } else {
          return Get.offAllNamed(Routes.TRANSACTION_PAGE);
        }
      },
    );
    await _notificationService.checkForNotifications();

    super.onReady();
  }
}
