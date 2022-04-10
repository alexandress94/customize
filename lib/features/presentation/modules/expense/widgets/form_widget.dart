import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organize_more/core/values/format/format_date.dart';

import 'package:organize_more/features/presentation/modules/expense/widgets/status_widget.dart';
import 'package:organize_more/features/presentation/theme/app_color.dart';
import 'package:organize_more/features/presentation/theme/app_constant.dart';
import '../../../global_widgets/global_action_buttom_widget.dart';
import '../controllers/insert_or_update_expense_controller.dart';
import '../../transactions/widgets/text_form_field_widget.dart';

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
              maxLenght: 80,
              editingController: controller.descriptionTextEditingController,
              hint: 'Conta de luz, roupas novas, internet...',
              icon: Icons.create,
              textInputType: TextInputType.name,
              validator: (description) {
                return controller.validatorDescription(description!);
              },
            ),
            SizedBox(height: appDefaultPadding.h),
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
              editingController: controller.moneyTextEditingController,
              icon: Icons.attach_money,
              textInputType: const TextInputType.numberWithOptions(),
              inputMask: [
                TextInputMask(
                  mask: '9+.999.999,99',
                  placeholder: '0',
                  maxPlaceHolders: 3,
                  reverse: true,
                )
              ],
              validator: (money) {
                return controller.validatorMoney(money!);
              },
            ),
            const SizedBox(height: appDefaultPadding),
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
                autofocus: true,
                autocorrect: true,
                readOnly: true,
                keyboardType: TextInputType.datetime,
                onTap: () {
                  _showDatePicker(context: context);
                },
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppLightColors.appWhiteColor,
                      width: 2,
                    ),
                  ),
                  isDense: true,
                  hintText:
                      FormatDate.replaceMaskDate(date: controller.date.value),
                  prefixIcon: const Icon(Icons.calendar_month),
                  suffixIcon: const Icon(Icons.keyboard_arrow_down),
                ),
              ),
            ),
            SizedBox(height: 10.0.h),
            const StatusWidget(),
            SizedBox(height: 20.0.h),
            controller.arguments['visibility']
                ? Visibility(
                    replacement: const SizedBox.shrink(),
                    visible: controller.isLoading.isFalse,
                    child: GlobalActionButtomWidget(
                        title: 'Cadastrar',
                        icon: Icons.check,
                        onTap: () async {
                          await controller.insertExpense();
                        }),
                  )
                : Visibility(
                    replacement: const SizedBox.shrink(),
                    visible: controller.isLoading.isFalse,
                    child: GlobalActionButtomWidget(
                        icon: Icons.save_outlined,
                        title: 'Salvar',
                        onTap: () async {
                          await controller.updateExpense();
                        }),
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
        return Theme(
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
    }
  }
}
