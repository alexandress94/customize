import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organize_more/features/presentation/global_widgets/global_action_buttom_widget.dart';
import 'package:organize_more/features/presentation/modules/on_error/controller/on_error_controller.dart';
import 'package:organize_more/features/presentation/routes/routes.dart';
import 'package:organize_more/features/presentation/theme/app_color.dart';

import '../../utils/path_lottie.dart';

class OnErrorPage extends GetView<OnErrorController> {
  const OnErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Error 404',
          style: Theme.of(context).textTheme.headline5?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Opss! Perece que algo deu errado...',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 15.0.h),
            Text(
              'Não desista, estamos trabalhando para resolver o problema.',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: AppLightColors.appSecondaryColor,
                  ),
            ),
            controller.getLottieAdpter().asset(
                  path: PathLottie.ERROR_404,
                ),
            GlobalActionButtomWidget(
                title: 'Tentar novamente',
                onTap: () {
                  Get.offAllNamed(Routes.INITIAL_PAGE);
                }),
          ],
        ),
      ),
    );
  }
}
