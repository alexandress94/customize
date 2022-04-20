import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organize_more/features/domain/entities/expense_entity.dart';

import '../../../../../core/models/expense_dto.dart';
import '../../../../../core/values/format/format_date.dart';
import '../../../../../core/values/format/format_money.dart';
import '../../../../../core/values/format/format_weekday.dart';
import '../../../global_widgets/global_action_buttom_widget.dart';
import '../../../theme/app_color.dart';
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
              'Deseja remover está despesa?',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: appDefaultPadding.h),
            RichText(
              text: TextSpan(
                text: 'Parcela: ',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        '${expense.amountInstallments}/${expense.installmentNumber}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0.h),
            RichText(
              text: TextSpan(
                text: 'Despesa: ',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                children: <TextSpan>[
                  TextSpan(
                    text: expense.description,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0.h),
            RichText(
              text: TextSpan(
                text: 'Valor: ',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                children: <TextSpan>[
                  TextSpan(
                    text: FormatMoney.outputMask(
                      expense.valueTransaction.toString(),
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0.h),
            RichText(
              text: TextSpan(
                text: 'Data de vencimento: ',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        '${FormatWeekday.descriptionWeekday(expense.dueDate)} ${FormatDate.replaceMaskDate(date: expense.dueDate)}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
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
                  Visibility(
                    visible:
                        controller.deleteExpenseController.isLoading.isFalse,
                    replacement: const SizedBox.shrink(),
                    child: GlobalActionButtomWidget(
                      icon: Icons.delete_outline,
                      color: appNormalDangerColor,
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
