import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organize_more/features/presentation/modules/expense/controllers/insert_or_update_expense_controller.dart';

import '../../../global_widgets/global_action_buttom_widget.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_constant.dart';

class ModalButtomSheetUpdateWithInstallmentWidget
    extends GetView<InsertOrUpdateExpenseController> {
  const ModalButtomSheetUpdateWithInstallmentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appDefaultPadding),
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Deseja atualizar esta despesa?',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: appDefaultPadding.h),
            Text(
              'Esta despesa possui outras parcelas. O que gostaria de fazer?',
              style: Get.textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0.h),
            Row(
              children: [
                Radio<Update>(
                  value: Update.update_one,
                  groupValue: controller.updateExpense.value,
                  onChanged: (Update? value) {
                    controller.updateExpense.value = value!;
                  },
                ),
                const Text('Atualizar apenas esta.')
              ],
            ),
            Row(
              children: [
                Radio<Update>(
                  value: Update.update_between,
                  groupValue: controller.updateExpense.value,
                  onChanged: (Update? value) {
                    controller.updateExpense.value = value!;
                  },
                ),
                const Text('Atualizar esta e as próximas.')
              ],
            ),
            Row(
              children: [
                Radio<Update>(
                  value: Update.update_all,
                  groupValue: controller.updateExpense.value,
                  onChanged: (Update? value) {
                    controller.updateExpense.value = value!;
                  },
                ),
                const Text('Atualizar todas.')
              ],
            ),
            const SizedBox(height: appDefaultPadding),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: controller.isLoading.isFalse,
                    replacement: const SizedBox.shrink(),
                    child: GlobalActionButtomWidget(
                      icon: Icons.save_outlined,
                      color: Get.isDarkMode
                          ? AppDarkColors.appBlueColor
                          : AppLightColors.appBlackColor,
                      title: 'Atualizar',
                      onTap: () {
                        controller.updateData();
                      },
                    ),
                  ),
                  const SizedBox(width: appDefaultPadding),
                  TextButton.icon(
                    icon: const Icon(Icons.subdirectory_arrow_left),
                    label: const Text('Cancelar'),
                    onPressed: () {
                      Get.back();
                      controller.updateExpense.value = Update.update_one;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
