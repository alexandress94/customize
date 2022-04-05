import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/values/format/format_money.dart';
import '../../../theme/app_color.dart';
import '../controllers/get_all_expense_controller.dart';

class SliverAppBarGridViewSumOfExpenseAndPaymentWidget
    extends GetView<GetAllExpenseController> {
  const SliverAppBarGridViewSumOfExpenseAndPaymentWidget({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      primary: false,
      expandedHeight: 250.0.h,
      backgroundColor: AppLightColors.appBarBackgroundColor,
      elevation: 0,
      centerTitle: true,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        background: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          padding: const EdgeInsets.all(16.0),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: AppLightColors.appWhiteColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppLightColors.appBarBackgroundColor,
                      ),
                      child: const Icon(Icons.trending_up),
                    ),
                    SizedBox(height: 15.0.h),
                    Text(
                      'Despesa com pagamento',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            letterSpacing: 1.5,
                            color: AppLightColors.appSecondaryColor,
                          ),
                    ),
                    SizedBox(height: 15.0.h),
                    Obx(
                      () => FittedBox(
                        child: Text(
                          FormatMoney.outputMask(
                            controller.getPaymentSum.toString(),
                          ),
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontSize: 18.0.h,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: AppLightColors.appWhiteColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppLightColors.appBarBackgroundColor,
                      ),
                      child: const Icon(Icons.trending_down),
                    ),
                    SizedBox(height: 15.0.h),
                    Text(
                      'Despesa sem pagamento',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            letterSpacing: 1.5,
                            color: AppLightColors.appSecondaryColor,
                          ),
                    ),
                    SizedBox(height: 15.0.h),
                    Obx(
                      () => FittedBox(
                        child: Text(
                          FormatMoney.outputMask(
                            controller.getSumOfExpenses.toString(),
                          ),
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontSize: 18.0.h,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        centerTitle: true,
      ),
    );
  }
}
