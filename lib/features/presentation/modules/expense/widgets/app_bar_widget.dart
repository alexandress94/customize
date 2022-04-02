import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organize_more/features/presentation/modules/transaction/controllers/insert_expense_controller.dart';

class AppBarWidget extends GetView<InsertExpenseController> {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        Text(
          'Cadastrar despesa',
          style: Get.textTheme.headline5?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
