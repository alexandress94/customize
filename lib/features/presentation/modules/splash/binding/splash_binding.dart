import 'package:customize/core/services/local_notification/local_notification_service.dart';
import 'package:customize/core/services/packages/contracts/local_get_storage.dart';
import 'package:customize/core/services/service_controller/check_native_darkmode_service_controller.dart';
import 'package:get/get.dart';
import 'package:customize/features/presentation/modules/splash/controller/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      SplashController(
        storage: Get.find<LocalGetStorage>(),
        service: Get.find<CheckNativeDarkmodeServiceController>(),
        notificationService: Get.find<LocalNotificationService>(),
      ),
    );
  }
}
