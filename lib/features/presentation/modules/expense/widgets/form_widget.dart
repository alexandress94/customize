import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:customize/core/values/format/format_date.dart';
import 'package:customize/features/presentation/modules/expense/widgets/modal_buttom_sheet_update_with_installment_widget.dart';

import 'package:customize/features/presentation/theme/app_color.dart';
import '../../../global_widgets/global_action_buttom_widget.dart';
import '../../../theme/app_constant.dart';
import '../controllers/insert_or_update_expense_controller.dart';
import '../../transactions/widgets/text_form_field_widget.dart';
import 'status_widget.dart';

class FormWidget extends GetView<InsertOrUpdateExpenseController> {
  const FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: controller.getFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Descrição',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: AppLightColors.appSecondaryColor,
                    ),
              ),
            ),
            SizedBox(height: 10.0.h),
            TextFormFieldWidget(
              textInputAction: TextInputAction.next,
              maxLenght: 80,
              editingController: controller.descriptionTextEditingController,
              hint: 'Conta de luz, roupas novas, internet...',
              icon: Icons.create,
              textInputType: TextInputType.name,
              validator: (description) {
                return controller.validatorDescription(description!);
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Valor R\$',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: AppLightColors.appSecondaryColor,
                    ),
              ),
            ),
            SizedBox(height: 10.0.h),
            TextFormFieldWidget(
              onFieldSubmitted: (_) => controller.arguments['visibility']
                  ? controller.insertExpense()
                  : controller.updateExpense(),
              textInputAction: TextInputAction.go,
              editingController: controller.moneyTextEditingController,
              icon: Icons.attach_money,
              textInputType: const TextInputType.numberWithOptions(),
              inputMask: [
                TextInputMask(
                  mask: '9+.999.999,99',
                  placeholder: '0',
                  maxPlaceHolders: 3,
                  reverse: true,
                  maxLength: 9,
                )
              ],
              validator: (money) {
                return controller.validatorMoney(money!);
              },
            ),
            SizedBox(height: 30.0.h),
            const StatusWidget(),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Data de vencimento',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: AppLightColors.appSecondaryColor,
                    ),
              ),
            ),
            SizedBox(height: 10.0.h),
            Obx(
              () => TextFormField(
                controller: controller.dueDateController,
                autofocus: true,
                autocorrect: true,
                readOnly: true,
                keyboardType: TextInputType.text,
                onTap: () {
                  _showDatePicker(context: context);
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Get.isDarkMode
                          ? AppDarkColors.appSecondaryBackgroundColor
                          : AppLightColors.appWhiteColor,
                      width: 2,
                    ),
                  ),
                  isDense: true,
                  hintText:
                      FormatDate.replaceMaskDate(date: controller.date.value),
                  prefixIcon: Icon(
                    Icons.calendar_month,
                    color: Get.isDarkMode
                        ? AppDarkColors.appWhiteColor
                        : AppLightColors.appIconGrayColor,
                  ),
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Get.isDarkMode
                        ? AppDarkColors.appWhiteColor
                        : AppLightColors.appIconGrayColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 70.0.h),
            controller.arguments['visibility']
                ? Visibility(
                    replacement: const SizedBox.shrink(),
                    visible: controller.isLoading.isFalse,
                    child: GlobalActionButtomWidget(
                      color: Get.isDarkMode
                          ? AppDarkColors.appBlueColor
                          : AppLightColors.appBlackColor,
                      title: 'Cadastrar',
                      icon: Icons.check,
                      onTap: () async {
                        await controller.insertExpense();
                      },
                    ),
                  )
                : Visibility(
                    replacement: const SizedBox.shrink(),
                    visible: controller.isLoading.isFalse,
                    child: GlobalActionButtomWidget(
                      color: Get.isDarkMode
                          ? AppDarkColors.appBlueColor
                          : AppLightColors.appBlackColor,
                      icon: Icons.save_outlined,
                      title: 'Salvar',
                      onTap:
                          controller.arguments['ExpenseEntity'].isPortion == 1
                              ? () {
                                  _displayModalBottonSheet(context: context);
                                }
                              : () {
                                  controller.singleUpdate();
                                },
                    ),
                  ),
            TextButton.icon(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.subdirectory_arrow_left),
              label: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDatePicker({required BuildContext context}) async {
    final DateTime? _selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(
        const Duration(days: 1000),
      ),
      builder: (BuildContext context, Widget? child) {
        return Get.isDarkMode
            ? Theme(
                data: ThemeData.dark().copyWith(
                  dialogBackgroundColor:
                      AppDarkColors.appSecondaryBackgroundColor,
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      primary: AppDarkColors.appWhiteColor,
                    ),
                  ),
                  colorScheme: ColorScheme.dark().copyWith(
                    primary: AppDarkColors.appBlueColor,
                    onPrimary: AppDarkColors.appWhiteColor,
                    onSurface: AppDarkColors.appWhiteColor,
                    surface: AppDarkColors.appPrimeryBackgroundColor,
                  ),
                ),
                child: child!,
              )
            : Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AppLightColors.appSecondaryColor,
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      primary: AppLightColors.appBlackColor,
                    ),
                  ),
                  colorScheme: ColorScheme.fromSwatch().copyWith(
                    primary: AppLightColors.appBlackColor,
                    secondary: AppLightColors.appBlackColor,
                  ),
                ),
                child: child!,
              );
      },
    );
    if (_selected != null && _selected != controller.date.value) {
      controller.date.value = _selected;
      controller.selectedDueDateCreateExpense();
    }
  }

  void _displayModalBottonSheet({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(appDefaultPadding),
          topRight: Radius.circular(appDefaultPadding),
        ),
      ),
      builder: (_) {
        return ModalButtomSheetUpdateWithInstallmentWidget();
      },
    );
  }
}
