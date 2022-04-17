import 'package:get/get.dart';
import 'package:organize_more/core/services/packages/contracts/local_get_storage.dart';
import 'package:organize_more/features/presentation/routes/routes.dart';

import '../../../../../core/services/packages/contracts/lottie_adapter.dart';
import '../../../../../core/values/keys/keys.dart';

class OnboardingController extends GetxController {
  final LottieAdapter _lottieAdpter;
  final LocalGetStorage _storage;

  OnboardingController({
    required LottieAdapter lottieAdpter,
    required LocalGetStorage storage,
  })  : _lottieAdpter = lottieAdpter,
        _storage = storage;

  LottieAdapter getLottieAdpter() => _lottieAdpter;

  Future<void> navigatorTransactionPage() async {
    await _storage.write(key: Keys.DISPLAY_ONBOARDING, value: false);
    Get.offAllNamed(Routes.TRANSACTION_PAGE);
  }
}
