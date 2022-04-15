import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organize_more/features/presentation/theme/app_color.dart';
import 'package:organize_more/features/presentation/theme/app_constant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/insert_or_update_expense_controller.dart';
import '../../transactions/widgets/text_form_field_widget.dart';

class StatusWidget extends GetView<InsertOrUpdateExpenseController> {
  const StatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: controller.arguments['visibility'],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Deseja parcelar?'),
              const SizedBox(width: appDefaultPadding),
              const Text('Não'),
              GetBuilder<InsertOrUpdateExpenseController>(
                id: 'modified-plot',
                builder: (_) {
                  return Radio<Portion>(
                    value: Portion.not,
                    groupValue: controller.installmentStatus,
                    onChanged: (Portion? value) {
                      return controller.selectedNo(value);
                    },
                  );
                },
              ),
              const Text('Sim'),
              GetBuilder<InsertOrUpdateExpenseController>(
                id: 'modified-plot',
                builder: (_) {
                  return Radio<Portion>(
                    value: Portion.yeas,
                    groupValue: controller.installmentStatus,
                    onChanged: (Portion? value) {
                      return controller.selectedYeas(value);
                    },
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 15.0.h),
          GetBuilder<InsertOrUpdateExpenseController>(
              id: 'visibility-dropbuttom',
              builder: (_) {
                return Visibility(
                  visible: controller.isSelectedYes.value,
                  child: DropdownButtonFormField(
                    autofocus: false,
                    dropdownColor: Get.isDarkMode
                        ? AppDarkColors.appSecondaryBackgroundColor
                        : AppLightColors.appSecondaryBackgroundColor,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Get.isDarkMode
                                ? AppDarkColors.appSecondaryBackgroundColor
                                : AppLightColors.appWhiteColor,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Get.isDarkMode
                                ? AppDarkColors.appSecondaryBackgroundColor
                                : AppLightColors.appWhiteColor,
                          ),
                        )),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Get.isDarkMode
                          ? AppDarkColors.appWhiteColor
                          : AppLightColors.appIconGrayColor,
                    ),
                    isExpanded: true,
                    value: controller.selectedItem.value,
                    items: controller.suggestionMenuItems
                        .map(_buildMenuItem)
                        .toList(),
                    onChanged: (String? value) {
                      controller.selectedItem.value = value!;
                    },
                  ),
                );
              }),
          const SizedBox(height: appDefaultPadding),
          GetBuilder<InsertOrUpdateExpenseController>(
            id: 'modified-plot',
            builder: (_) {
              return Visibility(
                visible: controller.isSelectedPlot.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quantidade de parcela',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: AppLightColors.appSecondaryColor,
                          ),
                    ),
                    SizedBox(height: 10.0.h),
                    TextFormFieldWidget(
                      maxLenght: 2,
                      editingController: controller.portionditingController,
                      icon: Icons.add,
                      textInputType: const TextInputType.numberWithOptions(),
                      validator: (installment) {
                        return controller.validatorPortion(installment!);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> _buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}
