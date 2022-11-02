import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:customize/core/values/format/format_money.dart';
import 'package:customize/core/values/format/format_weekday.dart';
import 'package:customize/features/domain/entities/expense_entity.dart';
import 'package:customize/features/presentation/theme/app_color.dart';

import '../../../../../core/values/format/format_date.dart';
import '../../../global_widgets/global_action_buttom_widget.dart';
import '../../../theme/app_constant.dart';
import '../controllers/delete_expense_controller.dart';
import '../controllers/get_all_expense_controller.dart';

class ModalButtomSheetDeleteOnExpensetWidget
    extends GetView<GetAllExpenseController> {
  final ExpenseEntity expense;

  const ModalButtomSheetDeleteOnExpensetWidget({
    Key? key,
    required this.expense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appDefaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 135.w,
              height: 5.67.h,
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? AppDarkColors.appPrimeryOnboardingColor
                    : AppLightColors.appSecondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(100.0)),
              ),
            ),
          ),
          const SizedBox(height: 25.33),
          Text(
            'Deseja remover está despesa?',
            style: Get.textTheme.headline6?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: appDefaultPadding.h),
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
              text: 'Valor: ',
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
          SizedBox(height: appDefaultPadding.h),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: controller.deleteExpenseController.isLoading.isFalse,
                  replacement: const SizedBox.shrink(),
                  child: GlobalActionButtomWidget(
                    icon: Icons.delete_outline,
                    color: appNormalDangerColor,
                    title: 'Remover',
                    onTap: () {
                      controller.deleteExpenseController.delete(expense.id!);
                      // controller.deleteExpenseController.delete(expense.id!);
                      controller.find();
                      // Fecha o alert dialog
                      Get.back();
                      // fecha o modal bottom sheet.
                      // Get.back();
                    },
                  ),
                ),
                const SizedBox(width: appDefaultPadding),
                TextButton.icon(
                  icon: const Icon(Icons.subdirectory_arrow_left),
                  label: const Text('Cancelar'),
                  onPressed: () {
                    Get.back();
                    controller.deleteExpenseController.remove.value =
                        Delete.delete_one;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
