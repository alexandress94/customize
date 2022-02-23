import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organize_more/features/presentation/theme/app_color.dart';
import 'package:organize_more/features/presentation/theme/app_constant.dart';
import 'package:organize_more/features/presentation/theme/app_style.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Minhas despesas',
            style: Get.textTheme.headline5?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: appDefaultPadding,
              vertical: appDefaultPadding / 2,
            ),
            decoration: BoxDecoration(
                color: appDarkSecondaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                    offset: Offset(5, 5),
                  )
                ]
                // border: Border.all(color: Colors.white10),
                ),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                print('OPEN SETTINGS');
              },
              child: const Icon(Icons.settings_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
