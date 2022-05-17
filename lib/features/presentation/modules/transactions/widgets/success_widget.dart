import 'package:customize/core/values/format/format_date.dart';
import 'package:customize/core/values/format/format_money.dart';

import 'package:customize/features/presentation/modules/transactions/widgets/modal_bottom_sheet_datails_widget.dart';
import 'package:customize/features/presentation/theme/app_color.dart';
import 'package:customize/features/presentation/theme/app_constant.dart';
import 'package:customize/features/domain/entities/expense_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_all_expense_controller.dart';

class SuccessWidget extends GetView<GetAllExpenseController> {
  const SuccessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext _, int index) {
            ExpenseEntity expense = controller.getAllExpenses[index];

            Widget displayPlots() => expense.isPortion == 1
                ? Text(
                    '${expense.amountInstallments}/${expense.installmentNumber}')
                : const SizedBox.shrink();

            return Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                bottom: 5.0,
              ),
              child: ListTile(
                key: ValueKey(expense.id),
                onTap: () {
                  _displayModalBottonSheet(
                    context: context,
                    expense: expense,
                  );
                },
                title: Text(
                  expense.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  FormatDate.replaceMaskDate(date: expense.dueDate),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: AppLightColors.appSecondaryColor,
                      ),
                ),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: controller.getAllExpenses.length,
        ),
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
        return ModalBottomSheetDatailsWidget(expense: expense);
      },
    );
  }
}
