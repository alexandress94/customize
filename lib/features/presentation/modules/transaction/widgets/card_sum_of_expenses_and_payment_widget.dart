import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organize_more/features/presentation/modules/transaction/controllers/get_all_expense_controller.dart';
import 'package:organize_more/features/presentation/theme/app_color.dart';
import '../../../../../core/values/format/format_money.dart';

class CardSumOfExpensesAndPaymentWidget
    extends GetView<GetAllExpenseController> {
  const CardSumOfExpensesAndPaymentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: appNormalSuccessColor,
                  ),
                  child: const Icon(
                    Icons.arrow_upward,
                    color: appLightBackgroundColor,
                  ),
                ),
                title: Text(
                  "Pago",
                  style: Get.textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: SizedBox(
                  width: 100,
                  child: FittedBox(
                    child: Obx(
                      () => Text(
                        FormatMoney.outputMask(
                          controller.getPaymentSum.toString(),
                        ),
                        style: Get.textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: appNormalDangerColor,
                  ),
                  child: const Icon(
                    Icons.arrow_downward,
                    color: appLightBackgroundColor,
                  ),
                ),
                title: Text(
                  "A pagar",
                  style: Get.textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: SizedBox(
                  width: 100,
                  child: FittedBox(
                    child: Obx(
                      () => Text(
                        FormatMoney.outputMask(
                          controller.getSumOfExpenses.toString(),
                        ),
                        style: Get.textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
