import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:organize_more/features/presentation/theme/app_color.dart';

class GlobalLoadingAnimationButtonWidget extends StatelessWidget {
  const GlobalLoadingAnimationButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        color: appDarkPrimaryColor,
        size: 50,
      ),
    );
  }
}
