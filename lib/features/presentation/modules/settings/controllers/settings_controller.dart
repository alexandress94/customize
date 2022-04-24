import 'package:get/get.dart';
import 'package:organize_more/core/services/packages/contracts/package_info_plus.dart';

import '../../../../../core/services/packages/contracts/url_launcher.dart';

class SettingsController extends GetxController {
  final UrlLaucher _launcher;
  final PackageInfoPlus _info;

  String appName = "";
  String appVersion = "";

  SettingsController({
    required UrlLaucher launcher,
    required PackageInfoPlus info,
  })  : _launcher = launcher,
        _info = info;

  Future<void> sendMenssage() async {
    await _launcher.open();
  }

  Future<void> displayBuildInfo() async {
    final build = await _info.fromPlatform();
    appName = build.appName;
    appVersion = build.version;
  }
}
