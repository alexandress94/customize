import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organize_more/features/presentation/global_widgets/global_action_buttom_widget.dart';

import 'package:organize_more/features/presentation/modules/transactions/widgets/modal_buttom_sheet_delete_with_installment_widget.dart';
import 'package:organize_more/features/presentation/routes/routes.dart';

import '../../../../../core/values/format/format_date.dart';
import '../../../../../core/values/format/format_money.dart';
import '../../../../../core/values/format/format_weekday.dart';
import '../../../../domain/entities/expense_entity.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_constant.dart';
import '../controllers/get_all_expense_controller.dart';
import 'modal_buttom_sheet_delete_one_expense.dart';

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
                onPressed: expense.isPortion == 1
                    ? () {
                        Get.back();
                        // _displayAlertDialog(context);
                        _displayModalBottonSheetDeleteWithInstallment(
                          context: context,
                          expense: expense,
                        );
                      }
                    : () {
                        Get.back();

                        _displayModalBottonSheetDeleteOneExpense(
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
          SizedBox(height: appDefaultPadding.h),
          expense.isPortion == 1
              ? RichText(
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
                )
              : const SizedBox.shrink(),
          SizedBox(height: 10.h),
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
              text: expense.isPortion != 0 ? 'Valor da parcela: ' : 'Valor: ',
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
          expense.isPortion != 0
              ? SizedBox(height: 10.0.h)
              : SizedBox(height: 0.0.h),
          expense.isPortion != 0
              ? RichText(
                  text: TextSpan(
                    text: 'Valor total: ',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: FormatMoney.outputMask(
                          expense.valueTotal.toString(),
                        ),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
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
          SizedBox(height: 10.0.h),
          RichText(
            text: TextSpan(
              text: 'Data de cadastro: ',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      '${FormatWeekday.descriptionWeekday(expense.transactionDate)} ${FormatDate.replaceMaskDate(date: expense.transactionDate)}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          SizedBox(height: appDefaultPadding.h),
          _verifyTransactionDate(expense),
          SizedBox(height: appDefaultPadding.h),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                expense.isPayment == 0
                    ? Visibility(
                        visible: controller
                            .updatePaymentController.isLoading.isFalse,
                        replacement: const SizedBox.shrink(),
                        child: GlobalActionButtomWidget(
                          color: Get.isDarkMode
                              ? AppDarkColors.appBlueColor
                              : AppLightColors.appBlackColor,
                          icon: Icons.check,
                          title: 'Confirmar pagamento',
                          onTap: () {
                            controller.updatePaymentController.updatePayment(
                              id: expense.id!,
                              portion: expense.installmentNumber,
                            );
                            controller.find();
                            Get.back();
                          },
                        ),
                      )
                    : GlobalActionButtomWidget(
                        icon: Icons.cached,
                        color: appNormalDangerColor,
                        title: 'Cancelar pagamento',
                        onTap: () {
                          controller.cancelPaymentController.cancelPayment(
                            id: expense.id!,
                            portion: expense.installmentNumber,
                          );
                          controller.find();
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

  Widget _verifyTransactionDate(ExpenseEntity expense) {
    DateTime now = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    return now.isAfter(expense.dueDate) && expense.isPayment == 0
        ? Row(
            children: [
              _modifyIconByDate(
                icon: Icons.event_busy,
                color: appNormalBackgroundCardDueDateColor,
                backgroundColor: appNormalDueDateColor,
              ),
              SizedBox(width: 20.0.h),
              const Text('Esta despesa está com vencimento.')
            ],
          )
        : now.isAtSameMomentAs(expense.dueDate) && expense.isPayment == 0
            ? Row(
                children: [
                  _modifyIconByDate(
                    backgroundColor: appNormalBackgroundCloseToExpirationColor,
                    icon: Icons.warning,
                    color: appNormalWarningColor,
                  ),
                  SizedBox(width: 20.0.h),
                  const Text('Esta despesa está próximo do vencimento.')
                ],
              )
            : now.isBefore(expense.dueDate) && expense.isPayment == 0
                ? Row(
                    children: [
                      _modifyIconByDate(
                        backgroundColor: appNormalInTimerColor,
                        icon: Icons.schedule,
                        color: appNormalBackgroundInTimerColor,
                      ),
                      SizedBox(width: 20.0.h),
                      const Text('Esta despesa está em dia.')
                    ],
                  )
                : Row(
                    children: [
                      _modifyIconByDate(
                        backgroundColor: appNormalBackgroundPaymentColor,
                        icon: Icons.check,
                        color: appNormalPaymentColor,
                      ),
                      SizedBox(width: 20.0.h),
                      const Text('Esta despesa consta como pagamento.')
                    ],
                  );
  }

  Widget _modifyIconByDate({
    required Color backgroundColor,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
      ),
      child: Icon(icon, color: color),
    );
  }

  void _displayModalBottonSheetDeleteWithInstallment({
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

  void _displayModalBottonSheetDeleteOneExpense({
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
        return ModalButtomSheetDeleteOnExpensetWidget(expense: expense);
      },
    );
  }
}
