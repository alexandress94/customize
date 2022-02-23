import 'package:organize_more/features/presentation/routes/routes.dart';
import 'package:organize_more/features/presentation/modules/transaction/controllers/get_all_expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
}
