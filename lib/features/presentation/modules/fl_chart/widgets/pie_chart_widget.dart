import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import 'package:customize/features/presentation/theme/app_color.dart';

import '../../transactions/controllers/get_all_expense_controller.dart';
import 'sum_of_expenses_widget.dart';

class PieChartWdiget extends GetView<GetAllExpenseController> {
  const PieChartWdiget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              startDegreeOffset: -90,
              centerSpaceRadius: 60,
              sections: [
                _pieChartSectionData(
                  value: 50,
                  color: appNormalSuccessColor,
                  radius: 24,
                ),
                _pieChartSectionData(
                  value: 20,
                  color: appNormalDangerColor,
                  radius: 22,
                ),
                _pieChartSectionData(
                  value: 10,
                  color: appNormalInTimerColor,
                  radius: 18,
                ),
                _pieChartSectionData(
                  value: 10,
                  color: appNormalWarningColor,
                  radius: 16,
                ),
              ],
            ),
          ),
          const Positioned.fill(
            child: SumOfExpensesWidget(),
          ),
        ],
      ),
    );
  }

  PieChartSectionData _pieChartSectionData({
    required double value,
    required Color color,
    required double radius,
  }) {
    return PieChartSectionData(
      value: value,
      color: color,
      showTitle: false,
      radius: radius,
    );
  }
}
