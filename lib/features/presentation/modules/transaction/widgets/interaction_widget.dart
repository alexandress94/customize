import 'package:organize_more/features/presentation/modules/transaction/controllers/get_all_expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organize_more/features/presentation/modules/transaction/widgets/modal_bottom_sheet_registration_widget.dart';

import '../../../routes/routes.dart';
import '../../../theme/app_constant.dart';

class InteractionWidget extends GetView<GetAllExpenseController> {
  const InteractionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: Get.width * 0.4,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () {
                Get.toNamed(Routes.EXPANSE_PAGE);
                // _displayModalBottonSheet(context: context);
              },
              icon: const Icon(Icons.playlist_add_outlined),
              label: const Text('Adicionar'),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  controller.backFilter();
                  controller.find();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              Obx(
                () => Text(
                  controller.getDescriptionOfFilterSelected().string,
                  style: Get.textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.nextFilter();
                  controller.find();
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ],
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
