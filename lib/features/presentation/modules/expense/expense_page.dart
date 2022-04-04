import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:organize_more/features/presentation/modules/transactions/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../transactions/controllers/insert_expense_controller.dart';

class ExpansePage extends GetView<InsertExpenseController> {
  const ExpansePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60.h),
        child: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            'Cadastrar despesa',
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: FormWidget(),
        ),
      ),
    );
  }
}
