import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../theme/app_color.dart';
import '../controllers/get_all_expense_controller.dart';

class SliverAppBarFilterOfMonthWidget extends GetView<GetAllExpenseController> {
  const SliverAppBarFilterOfMonthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Get.isDarkMode
          ? AppDarkColors.appPrimeryBackgroundColor
          : AppLightColors.appBarBackgroundColor,
      automaticallyImplyLeading: false,
      primary: false,
      toolbarHeight: 100.0.h,
      elevation: 0,
      centerTitle: true,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 15.0,
            right: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      controller.backFilter();
                      controller.find();
                    },
                    child: Icon(Icons.arrow_back_ios, size: 40),
                  ),
                  SizedBox(width: 15.0.h),
                  Obx(
                    () => Text(
                      controller.getDescriptionOfFilterSelected().string,
                      style: Get.textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 15.0.h),
                  InkWell(
                    onTap: () {
                      controller.nextFilter();
                      controller.find();
                    },
                    child: Icon(Icons.arrow_forward_ios, size: 40),
                  )
                ],
              ),
              SizedBox(height: 10.0.h),
              Text(
                'Últimas depesas cadastradas',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: AppLightColors.appSecondaryColor),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
