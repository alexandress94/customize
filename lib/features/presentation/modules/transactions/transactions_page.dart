import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organize_more/features/presentation/modules/transactions/widgets/on_empty_widget.dart';

import 'package:organize_more/features/presentation/modules/transactions/widgets/success_widget.dart';
import 'package:organize_more/features/presentation/routes/routes.dart';
import 'package:organize_more/features/presentation/theme/app_color.dart';

import '../../theme/app_constant.dart';
import 'widgets/modal_bottom_sheet_registration_widget.dart';
import 'controllers/get_all_expense_controller.dart';
import 'widgets/custom_app_bar_widget.dart';
import 'widgets/sliver_app_bar_filter_of_month_widget.dart';
import 'widgets/sliver_app_bar_grid_view_sum_of_expense_and_payment_widget.dart';
import 'widgets/sliver_app_bar_sum_of_month_widget.dart';

class TransactionsPage extends GetView<GetAllExpenseController> {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => NotificationListener<ScrollNotification>(
        onNotification: controller.handleScrollNotification,
        child: Scaffold(
          backgroundColor: AppLightColors.appBarBackgroundColor,
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 60.h),
            child: const CustomAppBarWidget(),
          ),
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverAppBarSumOfMonthWidget(),
              const SliverAppBarGridViewSumOfExpenseAndPaymentWidget(),
              const SliverAppBarFilterOfMonthWidget(),
              controller.getAllExpenses.isEmpty
                  ? const OnEmptyWidget()
                  : const SuccessWidget(),
            ],
          ),
          floatingActionButton: Visibility(
            visible: controller.isFabVisible.value,
            child: FloatingActionButton.extended(
              onPressed: () {
                // Get.toNamed(Routes.EXPANSE_PAGE);

                Get.offAllNamed(Routes.ERROR_PAGE);
              },
              label: Row(
                children: [
                  const Text('Adicionar'),
                  SizedBox(width: 10.0.h),
                  const Icon(Icons.add),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _displayModalBottonSheet({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      // isDismissible: false,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(appDefaultPadding),
          topRight: Radius.circular(appDefaultPadding),
        ),
      ),
      builder: (_) {
        return const ModalBottomSheetRegistrationWidget();
      },
    );
  }
}
