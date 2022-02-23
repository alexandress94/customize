import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organize_more/features/presentation/modules/transaction/controllers/get_all_expense_controller.dart';
import 'package:organize_more/features/presentation/routes/routes.dart';

import '../../../../../core/values/format/format_date.dart';
import '../../../../../core/values/format/format_money.dart';
import '../../../../domain/entities/expense_entity.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_constant.dart';

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
                  _displayAlertDialog(context);
                },
                icon: const Icon(Icons.delete),
                label: const Text('Remover'),
              ),
            ],
          ),
          const Divider(height: 1, thickness: 1),
          const SizedBox(height: appDefaultPadding),
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

  void _displayAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext _) {
        return AlertDialog(
          backgroundColor: appDarkBackgroundColor,
          title: const Text('Deseja completar a ação?'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Você está prestes a remover está transação'),
              Text('Tem certeza que deseja remover?')
            ],
          ),
          actions: [
            TextButton.icon(
              icon: const Icon(Icons.subdirectory_arrow_left),
              label: const Text('Cancelar'),
              onPressed: () {
                Get.back();
              },
            ),
            const SizedBox(width: appDefaultPadding),
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
            )
          ],
        );
      },
    );
  }
}
