import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:customize/features/presentation/modules/expense/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/insert_or_update_expense_controller.dart';

class ExpansePage extends GetView<InsertOrUpdateExpenseController> {
  const ExpansePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60.h),
        child: AppBar(
          centerTitle: false,
          elevation: 0.0,
          title: Text(
            controller.arguments['title-page'],
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          physics: BouncingScrollPhysics(),
          child: FormWidget(),
        ),
      ),
    );
  }
}
