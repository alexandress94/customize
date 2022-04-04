import 'package:flutter/material.dart';
import 'package:organize_more/features/presentation/theme/app_color.dart';
import 'package:organize_more/features/presentation/theme/app_constant.dart';

import '../../transactions/controllers/get_all_expense_controller.dart';
import 'indicator_widget.dart';
import 'pie_chart_widget.dart';
import 'package:get/get.dart';

class TransactionsInformationWidget extends GetView<GetAllExpenseController> {
  const TransactionsInformationWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Get.height * 0.25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const PieChartWdiget(),
          const SizedBox(width: appDefaultPadding),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                IndicatorWidget(
                  color: appDarkSecondaryColor,
                  text: 'N/D',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                IndicatorWidget(
                  color: appNormalInTimerColor,
                  text: 'Em dia',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                IndicatorWidget(
                  color: appNormalWarningColor,
                  text: 'Próx. venci.',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                IndicatorWidget(
                  color: appNormalSuccessColor,
                  text: 'Pago',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                IndicatorWidget(
                  color: appNormalDangerColor,
                  text: 'Vencido',
                  isSquare: true,
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
