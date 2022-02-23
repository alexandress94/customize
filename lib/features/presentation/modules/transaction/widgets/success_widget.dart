import 'package:organize_more/core/values/format/format_date.dart';
import 'package:organize_more/core/values/format/format_money.dart';
import 'package:organize_more/features/presentation/modules/transaction/controllers/get_all_expense_controller.dart';
import 'package:organize_more/features/presentation/modules/transaction/controllers/update_payment_controller.dart';
import 'package:organize_more/features/presentation/modules/transaction/widgets/modal_bottom_sheet_datails_widget.dart';
import 'package:organize_more/features/presentation/theme/app_color.dart';
import 'package:organize_more/features/presentation/theme/app_constant.dart';
import 'package:organize_more/features/domain/entities/expense_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessWidget extends GetView<GetAllExpenseController> {
  final List<ExpenseEntity> allExpenses;
  const SuccessWidget({Key? key, required this.allExpenses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: allExpenses.length,
      padding: const EdgeInsets.symmetric(vertical: appDefaultPadding),
      itemBuilder: (BuildContext _, int index) {
        ExpenseEntity expense = allExpenses[index];

        Widget displayPlots() => expense.isPortion == 1
            ? Text('${expense.amountInstallments}/${expense.installmentNumber}')
            : const SizedBox.shrink();

        return Card(
          elevation: 5.0,
          child: ListTile(
            onTap: () {
              _displayModalBottonSheet(
                context: context,
                expense: expense,
              );
            },
            title: Text(
              expense.description,
              style: Get.textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(FormatDate.replaceMaskDate(date: expense.dueDate)),
            leading: _verifyTransactionDate(expense),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                displayPlots(),
                const SizedBox(height: 5),
                Text(
                  FormatMoney.outputMask(
                    expense.valueTransaction.toString(),
                  ),
                  style: Get.textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _verifyTransactionDate(ExpenseEntity expense) {
    DateTime now = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    return now.isAfter(expense.dueDate) && expense.isPayment == 0
        ? _modifyIconByDate(
            icon: Icons.event_busy,
            color: appNormalBackgroundCardDueDateColor,
            backgroundColor: appNormalDueDateColor,
          )
        : now.isAtSameMomentAs(expense.dueDate) && expense.isPayment == 0
            ? _modifyIconByDate(
                backgroundColor: appNormalBackgroundCloseToExpirationColor,
                icon: Icons.warning,
                color: appNormalWarningColor,
              )
            : now.isBefore(expense.dueDate) && expense.isPayment == 0
                ? _modifyIconByDate(
                    backgroundColor: appNormalInTimerColor,
                    icon: Icons.schedule,
                    color: appNormalBackgroundInTimerColor,
                  )
                : _modifyIconByDate(
                    backgroundColor: appNormalBackgroundPaymentColor,
                    icon: Icons.check,
                    color: appNormalPaymentColor,
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

  void _displayModalBottonSheet({
    required BuildContext context,
    required ExpenseEntity expense,
  }) {
    showModalBottomSheet(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(appDefaultPadding),
          topRight: Radius.circular(appDefaultPadding),
        ),
      ),
      builder: (_) {
        return ModalBottomSheetDatailsWidget(expense: expense);
      },
    );
  }
}
