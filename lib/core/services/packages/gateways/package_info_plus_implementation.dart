import 'package:customize/core/services/packages/contracts/package_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoPlusImplementation implements PackageInfoPlus {
  @override
  Future<PackageInfo> fromPlatform() async {
    return await PackageInfo.fromPlatform();
  }
}
