import 'package:flutter/material.dart';
import 'package:organize_more/features/presentation/theme/app_constant.dart';
import 'package:organize_more/features/presentation/utils/path_image.dart';
import 'package:get/get.dart';

class OnEmptyWidget extends StatelessWidget {
  const OnEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: appDefaultPadding),
          Text(
            'Nenhuma despesa cadastrada.',
            style: Get.textTheme.headline6?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: appDefaultPadding),
          Expanded(
            child: Image.asset(PathImage.COINS),
          ),
        ],
      ),
    );
  }
}
