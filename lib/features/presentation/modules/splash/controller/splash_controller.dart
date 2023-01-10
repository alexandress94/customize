import 'package:get/get.dart';
import 'package:customize/core/services/packages/contracts/local_get_storage.dart';
import 'package:customize/core/services/service_controller/check_native_darkmode_service_controller.dart';
import 'package:customize/core/values/keys/keys.dart';

import '../../../routes/routes.dart';

class SplashController extends GetxController {
  final LocalGetStorage _storage;
  final CheckNativeDarkmodeServiceController _service;

  SplashController({
    required LocalGetStorage storage,
    required CheckNativeDarkmodeServiceController service,
  })  : _storage = storage,
        _service = service;

  CheckNativeDarkmodeServiceController get service => _service;

  @override
  void onReady() async {
    Future.delayed(
      Duration(milliseconds: 800),
      () async {
        if (await _storage.read(Keys.DISPLAY_ONBOARDING) ?? true) {
          return Get.offAllNamed(Routes.ONBOARDING_PAGE);
        } else {
          return Get.offAllNamed(Routes.TRANSACTION_PAGE);
        }
      },
    );

    super.onReady();
  }
}
