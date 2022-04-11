import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:organize_more/features/presentation/theme/app_color.dart';

import '../../../../core/services/service_controller/theme_service_controller.dart';
import 'controllers/settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60.h),
        child: AppBar(
          centerTitle: false,
          elevation: 0.0,
          title: Text(
            'Configurações',
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        children: [
          GetBuilder<SettingsController>(
              id: 'change-theme',
              builder: (_) {
                return _listTitle(
                  context: context,
                  title: 'Tema dark',
                  subtitle: 'Altere o tema do aplicativo',
                  trailing: Switch(
                      value: ThemeServiceController().isSavedDarkMode(),
                      onChanged: (theme) {
                        ThemeServiceController().changeThemeMode();
                      }),
                  iconLeading: Icons.brightness_medium_outlined,
                );
              }),
          const Divider(height: 1, thickness: 1),
          _listTitle(
            onTap: () {},
            context: context,
            title: 'Ajuda',
            subtitle: 'Envie sua dúvida ou nos ajude a melhorar',
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Get.isDarkMode
                  ? AppDarkColors.appBarBackgroundColor
                  : AppLightColors.appIconGrayColor,
            ),
            iconLeading: Icons.support_agent,
          ),
        ],
      ),
    );
  }

  ListTile _listTitle({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData iconLeading,
    required Widget trailing,
    void Function()? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      trailing: trailing,
      leading: Icon(
        iconLeading,
        color: Get.isDarkMode
            ? AppDarkColors.appBarBackgroundColor
            : AppLightColors.appIconGrayColor,
        size: 40,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode
                  ? AppDarkColors.appWhiteColor
                  : AppLightColors.appBlackColor,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: AppLightColors.appSecondaryColor,
            ),
      ),
    );
  }
}
