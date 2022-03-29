import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organize_more/features/domain/entities/expense_entity.dart';
import 'package:organize_more/features/presentation/modules/transaction/controllers/delete_expense_controller.dart';
import 'package:organize_more/features/presentation/modules/transaction/controllers/get_all_expense_controller.dart';

import '../../../../../core/models/expense_dto.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_constant.dart';

class ModalButtomSheetDeleteWidget extends GetView<GetAllExpenseController> {
  final ExpenseEntity expense;

  const ModalButtomSheetDeleteWidget({
    Key? key,
    required this.expense,
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
              'Deseja completar está ação?',
              style: Get.textTheme.headline6,
            ),
            const SizedBox(height: appDefaultPadding),
            Text(
              'Ao remover este item não será possível recuperá-lo.',
              style: Get.textTheme.bodyText1,
            ),
            const SizedBox(height: appDefaultPadding),
            Row(
              children: [
                Radio<Delete>(
                  value: Delete.delete_one,
                  groupValue: controller.deleteExpenseController.remove.value,
                  onChanged: (Delete? value) {
                    controller.deleteExpenseController.remove.value = value!;
                  },
                ),
                const Text('Remover apenas esta.')
              ],
            ),
            Row(
              children: [
                Radio<Delete>(
                  value: Delete.delete_between,
                  groupValue: controller.deleteExpenseController.remove.value,
                  onChanged: (Delete? value) {
                    controller.deleteExpenseController.remove.value = value!;
                  },
                ),
                const Text('Remover esta e as próximas.')
              ],
            ),
            Row(
              children: [
                Radio<Delete>(
                  value: Delete.delete_all,
                  groupValue: controller.deleteExpenseController.remove.value,
                  onChanged: (Delete? value) {
                    controller.deleteExpenseController.remove.value = value!;
                  },
                ),
                const Text('Remover todas.')
              ],
            ),
            const SizedBox(height: appDefaultPadding),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Get.width * 0.4,
                    height: 40,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          appNormalDangerColor,
                        ),
                      ),
                      onPressed: () {
                        controller.deleteExpenseController.deleteExpense(
                          ExpenseDto.fromEntity(entity: expense),
                        );
                        // controller.deleteExpenseController.delete(expense.id!);
                        controller.find();
                        // Fecha o alert dialog
                        Get.back();
                        // fecha o modal bottom sheet.
                        // Get.back();
                      },
                      icon: const Icon(Icons.delete_forever),
                      label: const Text('Remover'),
                    ),
                  ),
                  const SizedBox(width: appDefaultPadding),
                  TextButton.icon(
                    icon: const Icon(Icons.subdirectory_arrow_left),
                    label: const Text('Cancelar'),
                    onPressed: () {
                      Get.back();
                      controller.deleteExpenseController.remove.value =
                          Delete.delete_one;
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
