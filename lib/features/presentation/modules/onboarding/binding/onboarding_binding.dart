import 'package:get/get.dart';
import 'package:customize/core/services/packages/gateways/lottie_adapter_implementation.dart';
import 'package:customize/features/presentation/modules/onboarding/controller/onboarding_controller.dart';

class OnboardingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      OnboardingController(
        lottieAdpter: LottieAdapterImplementation(),
        storage: Get.find(),
        service: Get.find(),
      ),
    );
  }
}
