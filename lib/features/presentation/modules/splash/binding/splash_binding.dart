import 'package:get/get.dart';
import 'package:organize_more/features/presentation/modules/splash/controller/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashController(storage: Get.find()));
  }
}
