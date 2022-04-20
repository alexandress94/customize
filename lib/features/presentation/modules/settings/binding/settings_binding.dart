import 'package:get/get.dart';
import 'package:organize_more/core/services/packages/gateways/url_launcher_implementation.dart';
import 'package:organize_more/features/presentation/modules/settings/controllers/settings_controller.dart';

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingsController>(
      SettingsController(
        launcher: UrlLaucherImplementation(),
      ),
    );
  }
}
