import 'package:get/get.dart';
import 'package:organize_more/core/services/packages/contracts/local_get_storage.dart';
import 'package:organize_more/core/services/service_controller/check_native_darkmode_service_controller.dart';
import 'package:organize_more/features/presentation/routes/routes.dart';

import '../../../../../core/services/packages/contracts/lottie_adapter.dart';
import '../../../../../core/values/keys/keys.dart';

class OnboardingController extends GetxController {
  final LottieAdapter _lottieAdpter;
  final LocalGetStorage _storage;
  final CheckNativeDarkmodeServiceController _service;

  OnboardingController({
    required LottieAdapter lottieAdpter,
    required LocalGetStorage storage,
    required CheckNativeDarkmodeServiceController service,
  })  : _lottieAdpter = lottieAdpter,
        _storage = storage,
        _service = service;

  LottieAdapter getLottieAdpter() => _lottieAdpter;
  CheckNativeDarkmodeServiceController get service => _service;

  Future<void> navigatorTransactionPage() async {
    await _storage.write(key: Keys.DISPLAY_ONBOARDING, value: false);
    Get.offAllNamed(Routes.TRANSACTION_PAGE);
  }
}
