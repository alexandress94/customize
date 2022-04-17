import 'package:get/get.dart';
import 'package:organize_more/core/services/packages/gateways/lottie_adapter_implementation.dart';
import 'package:organize_more/features/presentation/modules/onboarding/controller/onboarding_controller.dart';

class OnboardingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      OnboardingController(
        lottieAdpter: LottieAdapterImplementation(),
      ),
    );
  }
}
