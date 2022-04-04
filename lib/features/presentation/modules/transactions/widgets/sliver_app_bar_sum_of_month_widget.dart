import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/values/format/format_money.dart';
import '../../../theme/app_color.dart';
import '../controllers/get_all_expense_controller.dart';

class SliverAppBarSumOfMonthWidget extends GetView<GetAllExpenseController> {
  const SliverAppBarSumOfMonthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppLightColors.appBarBackgroundColor,
      automaticallyImplyLeading: false,
      primary: false,
      toolbarHeight: 100.0.h,
      elevation: 0,
      centerTitle: true,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Obx(
          () => Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 20.0,
              right: 20.0,
            ),
            child: Column(
              children: [
                SizedBox(height: 5.0.h),
                FittedBox(
                  child: Text(
                    FormatMoney.outputMask(
                      controller.getSumOfTransactions.toString(),
                    ),
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  'Total do mês',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: AppLightColors.appSecondaryColor,
                      ),
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
