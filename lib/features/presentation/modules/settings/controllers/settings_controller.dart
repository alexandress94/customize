import 'package:get/get.dart';

import '../../../../../core/services/packages/contracts/url_launcher.dart';

class SettingsController extends GetxController {
  final UrlLaucher _launcher;

  SettingsController({required UrlLaucher launcher}) : _launcher = launcher;

  Future<void> sendMenssage() async {
    await _launcher.open();
  }
}
