import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:customize/features/presentation/theme/app_color.dart';

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
            onTap: () {
              _displayWhoWeAre(context);
            },
            context: context,
            title: 'Quem somos',
            subtitle: 'Conheça um pouco mais sobre o projeto.',
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Get.isDarkMode
                  ? AppDarkColors.appBarBackgroundColor
                  : AppLightColors.appIconGrayColor,
            ),
            iconLeading: Icons.help_outline,
          ),
          SizedBox(height: 5.0.h),
          _listTitle(
            onTap: () {
              _displayAppVersion(context);
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
            iconLeading: Icons.check_circle_outline,
          ),
        ],
      ),
    );
  }

  Future<void> _displayAppVersion(BuildContext context) async {
    await controller.displayBuildInfo();
    return showDialog<void>(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Get.isDarkMode
              ? AppDarkColors.appPrimeryBackgroundColor
              : AppLightColors.appBarBackgroundColor,
          title: const Text('Detalhes do aplicativo'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Nome do app: ',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Get.isDarkMode
                            ? AppLightColors.appWhiteColor
                            : AppLightColors.appBlackColor,
                      ),
                  children: [
                    TextSpan(
                      text: controller.appName,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: AppLightColors.appSecondaryColor,
                          ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                    text: 'Versão: ',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Get.isDarkMode
                              ? AppLightColors.appWhiteColor
                              : AppLightColors.appBlackColor,
                        ),
                    children: [
                      TextSpan(
                        text: controller.appVersion,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: AppLightColors.appSecondaryColor,
                            ),
                      ),
                    ]),
              ),
            ],
          ),
          actions: [
            TextButton.icon(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close),
              label: Text('Sair'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _displayWhoWeAre(BuildContext context) async {
    await controller.displayBuildInfo();
    return showDialog<void>(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Get.isDarkMode
              ? AppDarkColors.appPrimeryBackgroundColor
              : AppLightColors.appBarBackgroundColor,
          title: const Text('Sobre o projeto'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Projeto realizado apenas por um desenvolvedor, com objetivo '
                'de resolver um problema pessoal na organização das despesas e também '
                'colocar os estudos em prática na área da programação. Como este projeto foi pensado '
                'apenas para consumo próprio, resolvi disponibilizá-lo para que possa ajudar outras pessoas afim '
                'de organizar suas despesas.',
                textAlign: TextAlign.justify,
              )
            ],
          ),
          actions: [
            TextButton.icon(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close),
              label: Text('Sair'),
            ),
          ],
        );
      },
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
