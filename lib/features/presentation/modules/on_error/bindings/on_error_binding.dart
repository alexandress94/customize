import 'package:get/get.dart';
import 'package:organize_more/core/services/packages/gateways/lottie_adapter_implementation.dart';
import 'package:organize_more/features/presentation/modules/on_error/controller/on_error_controller.dart';

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
