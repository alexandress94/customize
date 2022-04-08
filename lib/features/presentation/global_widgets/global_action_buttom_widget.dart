import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organize_more/features/presentation/theme/app_color.dart';

class GlobalActionButtomWidget extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  final void Function()? onTap;

  const GlobalActionButtomWidget({
    Key? key,
    required this.title,
    this.color = AppLightColors.appBlackColor,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20.0),
      color: color,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: onTap,
        child: Container(
          width: Get.width * 0.8,
          height: 60.0.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppLightColors.appWhiteColor),
              SizedBox(width: 10.0.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: AppLightColors.appWhiteColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
