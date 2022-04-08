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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Parcelar?'),
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
          const SizedBox(height: appDefaultPadding),
          GetBuilder<InsertOrUpdateExpenseController>(
            id: 'modified-plot',
            builder: (_) {
              return Visibility(
                visible: controller.isSelectedPlot.value,
                child: TextFormFieldWidget(
                  editingController: controller.portionditingController,
                  icon: Icons.add,
                  label: 'Parcela',
                  textInputType: const TextInputType.numberWithOptions(),
                  validator: (installment) {
                    return controller.validatorPortion(installment!);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
