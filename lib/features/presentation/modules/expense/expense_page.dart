import 'package:organize_more/features/presentation/modules/transaction/controllers/insert_expense_controller.dart';
import 'package:organize_more/features/presentation/modules/expense/widgets/app_bar_widget.dart';
import 'package:organize_more/features/presentation/modules/transaction/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpansePage extends GetView<InsertExpenseController> {
  const ExpansePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width,
                child: const AppBarWidget(),
              ),
              const FormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
