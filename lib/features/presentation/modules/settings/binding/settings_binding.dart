import 'package:get/get.dart';
import 'package:customize/core/services/packages/gateways/package_info_plus_implementation.dart';
import 'package:customize/core/services/packages/gateways/url_launcher_implementation.dart';
import 'package:customize/features/presentation/modules/settings/controllers/settings_controller.dart';

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingsController>(
      SettingsController(
        launcher: UrlLaucherImplementation(),
        info: PackageInfoPlusImplementation(),
      ),
    );
  }
}
