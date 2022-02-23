import 'package:organize_more/features/presentation/modules/transaction/widgets/interaction_widget.dart';
import 'package:organize_more/features/presentation/modules/transaction/widgets/on_empty.dart';
import 'package:organize_more/features/presentation/modules/transaction/widgets/on_loading_widget.dart';
import 'package:organize_more/features/presentation/modules/transaction/widgets/transactions_information_widget.dart';
import 'package:organize_more/features/presentation/modules/transaction/widgets/app_bar_widget.dart';
import 'package:organize_more/features/presentation/modules/transaction/widgets/success_widget.dart';
import 'package:organize_more/features/presentation/theme/app_constant.dart';

import 'controllers/get_all_expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/card_sum_of_expenses_and_payment_widget.dart';
import 'widgets/sum_of_expenses_widget.dart';

class TransactionPage extends GetView<GetAllExpenseController> {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBarWidget(),
              const SizedBox(height: 5),
              const CardSumOfExpensesAndPaymentWidget(),
              const SizedBox(height: 5),
              const TransactionsInformationWidget(),
              const InteractionWidget(),
              const SizedBox(height: 5),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: Get.height,
                  child: controller.obx(
                    (state) => SuccessWidget(
                      allExpenses: state!,
                    ),
                    onEmpty: const OnEmptyWidget(),
                    onLoading: const OnLoadingWidget(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
