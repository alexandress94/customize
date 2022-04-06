import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organize_more/features/presentation/global_widgets/global_action_buttom_widget.dart';

import 'package:organize_more/features/presentation/modules/transactions/widgets/modal_buttom_sheet_delete_with_installment_widget.dart';
import 'package:organize_more/features/presentation/routes/routes.dart';

import '../../../../../core/values/format/format_date.dart';
import '../../../../../core/values/format/format_money.dart';
import '../../../../domain/entities/expense_entity.dart';
import '../../../theme/app_constant.dart';
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
                onPressed: () {
                  Get.back();
                  Get.toNamed(
                    Routes.EXPANSE_PAGE,
                    arguments: {
                      "title-page": "Atualizar despesa",
                      "visibility": false,
                      "ExpenseEntity": expense,
                    },
                  );
                },
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
                    ? GlobalActionButtomWidget(
                        title: 'Confirmar pagamento',
                        onTap: () {
                          controller.updatePaymentController.updateExpense(
                            id: expense.id!,
                            portion: expense.installmentNumber,
                          );
                          controller.find();
                          Get.back();
                        },
                      )
                    : GlobalActionButtomWidget(
                        title: 'Cancelar pagamento',
                        onTap: () async {
                          await controller.find();
                          Get.back();
                        },
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
        return ModalButtomSheetDeleteWithInstallmentWidget(expense: expense);
      },
    );
  }
}
