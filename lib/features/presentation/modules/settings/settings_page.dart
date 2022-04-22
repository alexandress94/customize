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
        padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
        children: [
          Row(
            children: [
              Text(
                'Estilo',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(width: 20.0.h),
              Expanded(child: const Divider(height: 1, thickness: 1)),
            ],
          ),
          SizedBox(height: 5.0.h),
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
          SizedBox(height: 25.0.h),
          Row(
            children: [
              Text(
                'Suporte',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(width: 20.0.h),
              Expanded(child: const Divider(height: 1, thickness: 1)),
            ],
          ),
          SizedBox(height: 5.0.h),
          _listTitle(
            onTap: () {},
            context: context,
            title: 'Avalia-nos',
            subtitle: 'Nos ajude a melhorar envie sua avaliação',
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Get.isDarkMode
                  ? AppDarkColors.appBarBackgroundColor
                  : AppLightColors.appIconGrayColor,
            ),
            iconLeading: Icons.star_border,
          ),
          SizedBox(height: 5.0.h),
          _listTitle(
            onTap: controller.sendMenssage,
            context: context,
            title: 'Ajuda',
            subtitle: 'Envie sua mensagem',
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Get.isDarkMode
                  ? AppDarkColors.appBarBackgroundColor
                  : AppLightColors.appIconGrayColor,
            ),
            iconLeading: Icons.support_agent,
          ),
          SizedBox(height: 25.0.h),
          Row(
            children: [
              Text(
                'Sobre',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(width: 20.0.h),
              Expanded(child: const Divider(height: 1, thickness: 1)),
            ],
          ),
          SizedBox(height: 5.0.h),
          _listTitle(
            onTap: () {},
            context: context,
            title: 'Quem somos',
            subtitle: 'Conheça um pouco mais sobre o projeto.',
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Get.isDarkMode
                  ? AppDarkColors.appBarBackgroundColor
                  : AppLightColors.appIconGrayColor,
            ),
            iconLeading: Icons.assignment_ind,
          ),
          SizedBox(height: 5.0.h),
          _listTitle(
            onTap: () async {
              await controller.displayBuildInfo();
            },
            context: context,
            title: 'Versão atual',
            subtitle: 'Confira a versão atual do aplicativo.',
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Get.isDarkMode
                  ? AppDarkColors.appBarBackgroundColor
                  : AppLightColors.appIconGrayColor,
            ),
            iconLeading: Icons.check_box,
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
