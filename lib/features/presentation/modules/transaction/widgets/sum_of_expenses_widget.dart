import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organize_more/features/presentation/modules/transaction/controllers/get_all_expense_controller.dart';

import '../../../../../core/values/format/format_money.dart';

class SumOfExpensesWidget extends GetView<GetAllExpenseController> {
  const SumOfExpensesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Total do mês',
          style: Get.textTheme.bodyText1?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 90,
          child: FittedBox(
            child: Obx(
              () => Text(
                FormatMoney.outputMask(
                  controller.getSumOfTransactions.toString(),
                ),
                style: Get.textTheme.bodyText1,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
