import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:customize/features/presentation/modules/expense/controllers/insert_or_update_expense_controller.dart';
import 'package:customize/features/presentation/theme/app_color.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ToggleSwitchWidget extends GetView<InsertOrUpdateExpenseController> {
  final String labelOne;
  final String labelTwo;
  final void Function(int?)? onToggle;

  const ToggleSwitchWidget({
    Key? key,
    required this.labelOne,
    required this.labelTwo,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: ToggleSwitch(
        minWidth: double.infinity.w,
        minHeight: 58.0,
        initialLabelIndex: 0,
        cornerRadius: 20.0,
        activeFgColor: Colors.white,
        inactiveBgColor: Get.isDarkMode
            ? AppDarkColors.appSecondaryBackgroundColor
            : AppLightColors.appWhiteColor,
        inactiveFgColor: Get.isDarkMode
            ? AppDarkColors.appWhiteColor
            : AppLightColors.appSecondaryColor,
        totalSwitches: 2,
        labels: [labelOne, labelTwo],
        activeBgColors: Get.isDarkMode
            ? [
                [AppDarkColors.appBlueColor, AppDarkColors.appBlueColor],
                [AppDarkColors.appBlueColor, AppDarkColors.appBlueColor]
              ]
            : [
                [AppLightColors.appBlackColor, AppLightColors.appBlackColor],
                [AppLightColors.appBlackColor, AppLightColors.appBlackColor]
              ],
        animate: true,
        curve: Curves.easeInOutCubicEmphasized,
        onToggle: onToggle,
      ),
    );
  }
}
