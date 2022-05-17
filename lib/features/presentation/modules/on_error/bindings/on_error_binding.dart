import 'package:get/get.dart';
import 'package:customize/core/services/packages/gateways/lottie_adapter_implementation.dart';
import 'package:customize/features/presentation/modules/on_error/controller/on_error_controller.dart';

import '../../../../../core/services/packages/contracts/lottie_adapter.dart';

class OnErrorBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LottieAdapter>(LottieAdapterImplementation());
    Get.lazyPut<OnErrorController>(
      () => OnErrorController(lottieAdpter: Get.find()),
    );
  }
}
