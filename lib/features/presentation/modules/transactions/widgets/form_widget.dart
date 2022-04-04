import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:organize_more/core/values/format/format_date.dart';
import 'package:organize_more/core/values/format/format_money.dart';
import 'package:organize_more/features/presentation/global_widgets/global_action_buttom_widget.dart';

import 'package:organize_more/features/presentation/modules/transactions/widgets/status_widget.dart';
import 'package:organize_more/features/presentation/theme/app_color.dart';
import 'package:organize_more/features/presentation/theme/app_constant.dart';
import '../controllers/insert_expense_controller.dart';
import 'text_form_field_widget.dart';

class FormWidget extends GetView<InsertExpenseController> {
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
              validator: (value) {
                if (value!.isEmpty) {
                  return "Descrição obrigatório.";
                }
                return null;
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
              validator: (value) {
                if (FormatMoney.replaceMask(value: value!) <= 0.0) {
                  return "Valor obrigatório.";
                }
                return null;
              },
            ),
            const SizedBox(height: appDefaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Data de vencimento:'),
                GetBuilder<InsertExpenseController>(
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
            const SizedBox(height: appDefaultPadding),
            Visibility(
              replacement: const SizedBox.shrink(),
              visible: controller.isLoading.isFalse,
              child: GlobalActionButtomWidget(
                  title: 'Cadastrar',
                  onTap: () async {
                    await controller.insertExpense();
                  }),
              // child: SizedBox(
              //   width: Get.width * 0.7,
              //   height: 40,
              //   child: ElevatedButton.icon(
              //     icon: const Icon(Icons.check),
              //     onPressed: () async {
              //       await controller.insertExpense();
              //     },
              //     label: const Text('Cadastrar'),
              //   ),
              // ),
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