import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organize_more/features/domain/entities/expense_entity.dart';

import '../../../../../core/models/expense_dto.dart';
import '../../../global_widgets/global_action_buttom_widget.dart';
import '../../../theme/app_constant.dart';
import '../controllers/delete_expense_controller.dart';
import '../controllers/get_all_expense_controller.dart';

class ModalButtomSheetDeleteWithInstallmentWidget
    extends GetView<GetAllExpenseController> {
  final ExpenseEntity expense;

  const ModalButtomSheetDeleteWithInstallmentWidget({
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
                  GlobalActionButtomWidget(
                    title: 'Remover',
                    onTap: () {
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
