import 'package:get/get.dart';

import '../../../../../core/services/packages/contracts/lottie_adapter.dart';

class OnboardingController extends GetxController {
  final LottieAdapter _lottieAdpter;

  OnboardingController({required LottieAdapter lottieAdpter})
      : _lottieAdpter = lottieAdpter;

  LottieAdapter getLottieAdpter() => _lottieAdpter;
}
