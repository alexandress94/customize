import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:organize_more/core/values/format/format_date.dart';

import 'package:organize_more/features/presentation/modules/transactions/widgets/status_widget.dart';
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
            TextFormFieldWidget(
              editingController: controller.descriptionTextEditingController,
              label: 'Descrição',
              hint: 'Informe uma descrição',
              icon: Icons.create,
              textInputType: TextInputType.name,
              validator: (description) {
                return controller.validatorDescription(description!);
              },
            ),
            const SizedBox(height: appDefaultPadding),
            TextFormFieldWidget(
              editingController: controller.moneyTextEditingController,
              icon: Icons.attach_money,
              label: 'R\$ Valor',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Data de vencimento:'),
                GetBuilder<InsertOrUpdateExpenseController>(
                  id: 'selected-date',
                  builder: (_) {
                    return TextButton.icon(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: () {
                        _showDatePicker(context: context);
                      },
                      label: Text(
                        FormatDate.replaceMaskDate(
                          date: controller.getSelectedDate,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const StatusWidget(),
            SizedBox(height: 40.0.h),
            controller.arguments['visibility']
                ? Visibility(
                    replacement: const SizedBox.shrink(),
                    visible: controller.isLoading.isFalse,
                    child: GlobalActionButtomWidget(
                        title: 'Cadastrar',
                        onTap: () async {
                          await controller.insertExpense();
                        }),
                  )
                : Visibility(
                    replacement: const SizedBox.shrink(),
                    visible: controller.isLoading.isFalse,
                    child: GlobalActionButtomWidget(
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
          data: ThemeData.dark().copyWith(
            primaryColor: appDarkBackgroundColor,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: appDarkBodyColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (_selected != null && _selected != controller.getSelectedDate) {
      controller.setSelectedDate = _selected;
    }
  }
}
