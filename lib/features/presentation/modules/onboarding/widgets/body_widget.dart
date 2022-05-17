import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:customize/features/presentation/modules/onboarding/controller/onboarding_controller.dart';
import 'package:customize/features/presentation/theme/app_color.dart';

class SlideWidget extends GetView<OnboardingController> {
  final String lottie;
  final String title;
  final String description;

  const SlideWidget({
    Key? key,
    required this.lottie,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: controller
                .getLottieAdpter()
                .asset(path: lottie, height: 250.0.h, width: 250.0.w),
          ),
          SizedBox(height: 50.0.h),
          Text(
            title,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: AppLightColors.appWhiteColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 10.0.h),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: AppLightColors.appWhiteColor,
                ),
          ),
        ],
      ),
    );
  }
}
