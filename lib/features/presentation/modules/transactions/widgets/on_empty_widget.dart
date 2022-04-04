import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/path_lottie.dart';
import '../controllers/get_all_expense_controller.dart';

class OnEmptyWidget extends GetView<GetAllExpenseController> {
  const OnEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.0.h),
            Text(
              'Nenhuma despesa cadastrada.',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            controller.getLottieAdpter().asset(
                  path: PathLottie.BUSINESS_ANALYTICS,
                ),
          ],
        ),
      ),
    );
  }
}
