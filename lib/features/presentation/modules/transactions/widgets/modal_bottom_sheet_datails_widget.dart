import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:organize_more/features/presentation/modules/transactions/widgets/modal_buttom_sheet_delete_widget.dart';

import '../../../../../core/values/format/format_date.dart';
import '../../../../../core/values/format/format_money.dart';
import '../../../../domain/entities/expense_entity.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_constant.dart';
import '../controllers/delete_expense_controller.dart';
import '../controllers/get_all_expense_controller.dart';

class ModalBottomSheetDatailsWidget extends GetView<GetAllExpenseController> {
  final ExpenseEntity expense;
  const ModalBottomSheetDatailsWidget({
    Key? key,
    required this.expense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appDefaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Detalhes: ',
                style: Get.textTheme.headline6,
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.create),
                label: const Text('Editar'),
              ),
              const SizedBox(width: appDefaultPadding),
              TextButton.icon(
                onPressed: () {
                  Get.back();
                  // _displayAlertDialog(context);
                  _displayModalBottonSheet(
                    context: context,
                    expense: expense,
                  );
                },
                icon: const Icon(Icons.delete),
                label: const Text('Remover'),
              ),
            ],
          ),
          const Divider(height: 1, thickness: 1),
          const SizedBox(height: 6),
          expense.isPortion == 1
              ? RichText(
                  text: TextSpan(
                    text: 'Parcela: ',
                    style: Get.textTheme.headline6,
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            '${expense.amountInstallments}/${expense.installmentNumber}',
                        style: Get.textTheme.bodyText1,
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: appDefaultPadding),
          Text('Descrição: ${expense.description}'),
          const SizedBox(height: appDefaultPadding),
          Text(
            'valor: '
            '${FormatMoney.outputMask(expense.valueTransaction.toString())}',
          ),
          const SizedBox(height: appDefaultPadding),
          Text(
            'Vencimento: '
            '${FormatDate.replaceMaskDate(date: expense.dueDate)}',
          ),
          const SizedBox(height: appDefaultPadding),
          Text(
            'Cadastro: '
            '${FormatDate.replaceMaskDate(date: expense.transactionDate)}',
          ),
          const SizedBox(height: appDefaultPadding),
          expense.isPayment == 1
              ? const Text(
                  'Está parcela está paga.',
                )
              : const Text('Não consta pagamento para está parcela.'),
          const SizedBox(height: appDefaultPadding),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                expense.isPayment == 0
                    ? ElevatedButton.icon(
                        onPressed: () {
                          controller.updatePaymentController.updateExpense(
                            id: expense.id!,
                            portion: expense.installmentNumber,
                          );
                          controller.find();
                          Get.back();
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Confirmar pagamento'),
                      )
                    : ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            appNormalDangerColor,
                          ),
                        ),
                        onPressed: () {
                          controller.find();
                          Get.back();
                        },
                        icon: const Icon(Icons.autorenew),
                        label: const Text('Cancelar pagamento'),
                      ),
                TextButton.icon(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                  label: const Text('Sair'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _displayModalBottonSheet({
    required BuildContext context,
    required ExpenseEntity expense,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(appDefaultPadding),
          topRight: Radius.circular(appDefaultPadding),
        ),
      ),
      builder: (_) {
        return ModalButtomSheetDeleteWidget(expense: expense);
      },
    );
  }

  void _displayAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext _) {
        return AlertDialog(
          backgroundColor: appDarkBackgroundColor,
          title: const Text('Deseja completar está ação?'),
          content: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Ao remover este item não será possível recuperá-lo.',
                ),
                const SizedBox(height: appDefaultPadding),
                Row(
                  children: [
                    Radio<Delete>(
                      value: Delete.delete_one,
                      groupValue:
                          controller.deleteExpenseController.remove.value,
                      onChanged: (Delete? value) {
                        controller.deleteExpenseController.remove.value =
                            value!;
                      },
                    ),
                    const Text('Remover apenas esta.')
                  ],
                ),
                Row(
                  children: [
                    Radio<Delete>(
                      value: Delete.delete_between,
                      groupValue:
                          controller.deleteExpenseController.remove.value,
                      onChanged: (Delete? value) {
                        controller.deleteExpenseController.remove.value =
                            value!;
                      },
                    ),
                    const Text('Remover esta e as próximas.')
                  ],
                ),
                Row(
                  children: [
                    Radio<Delete>(
                      value: Delete.delete_all,
                      groupValue:
                          controller.deleteExpenseController.remove.value,
                      onChanged: (Delete? value) {
                        controller.deleteExpenseController.remove.value =
                            value!;
                      },
                    ),
                    const Text('Remover todas.')
                  ],
                ),
              ],
            ),
          ),
          actions: [
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
                        controller.deleteExpenseController.delete(expense.id!);
                        controller.find();
                        // Fecha o alert dialog
                        Get.back();
                        // fecha o modal bottom sheet.
                        Get.back();
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
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}