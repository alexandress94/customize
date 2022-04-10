import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organize_more/features/presentation/routes/routes.dart';
import 'package:organize_more/features/presentation/theme/app_color.dart';

import '../../../../../core/services/service_controller/theme_service_controller.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Organize mais',
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            'minhas despesas',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: AppLightColors.appSecondaryColor,
                ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Get.toNamed(Routes.SETTINGS_PAGE);
            ThemeServiceController().changeThemeMode();
            Get.offAllNamed(Routes.INITIAL_PAGE);
          },
          icon: const Icon(Icons.settings_outlined),
        )
      ],
    );
  }
}
