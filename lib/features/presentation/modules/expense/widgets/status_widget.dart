import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:customize/features/presentation/modules/expense/widgets/toggle_switch_widget.dart';
import 'package:customize/features/presentation/theme/app_color.dart';
import 'package:customize/features/presentation/theme/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/insert_or_update_expense_controller.dart';
import '../../transactions/widgets/text_form_field_widget.dart';

class StatusWidget extends GetView<InsertOrUpdateExpenseController> {
  const StatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      replacement: SizedBox.shrink(),
      visible: controller.arguments['visibility'],
      child: Column(
        children: [
          ToggleSwitchWidget(
            labelOne: 'Sem frequência',
            labelTwo: 'Parceladas',
            onToggle: (value) {
              controller.changeInstallmentType(value!);
              print(value);
            },
          ),
          Obx(
            () => Visibility(
              visible: controller.isValue.value,
              replacement: SizedBox(height: 0.0),
              child: SizedBox(height: appDefaultPadding),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.isValue.value,
              child: ToggleSwitchWidget(
                labelOne: 'Valor total',
                labelTwo: 'Valor parcelado',
                onToggle: (value) {
                  controller.changeExpenseAmountType(value!);
                  print(value);
                },
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.isValue.value,
              replacement: SizedBox(height: 0.0),
              child: SizedBox(height: appDefaultPadding),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.isSelectedYes.value,
              child: DropdownButtonFormField(
                autofocus: false,
                dropdownColor: Get.isDarkMode
                    ? AppDarkColors.appSecondaryBackgroundColor
                    : AppLightColors.appWhiteColor,
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
                items:
                    controller.suggestionMenuItems.map(_buildMenuItem).toList(),
                onChanged: (String? value) {
                  controller.selectedItem.value = value!;
                },
              ),
            ),
          ),
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
                      inputMask: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      maxLenght: 2,
                      editingController: controller.portionditingController,
                      icon: Icons.add,
                      textInputType: TextInputType.number,
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
