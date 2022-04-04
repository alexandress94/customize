import 'package:get/get.dart';

import '../../../../../core/services/packages/contracts/lottie_adapter.dart';

class OnErrorController extends GetxController {
  final LottieAdapter _lottieAdpter;
  LottieAdapter getLottieAdpter() => _lottieAdpter;

  OnErrorController({required LottieAdapter lottieAdpter})
      : _lottieAdpter = lottieAdpter;
}
