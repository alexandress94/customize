import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:organize_more/features/presentation/theme/app_color.dart';
import 'package:shimmer/shimmer.dart';

class OnLoadingWidget extends StatelessWidget {
  const OnLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 6,
        itemBuilder: (BuildContext _, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(microseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Shimmer.fromColors(
                  child: const SizedBox(
                    height: 100,
                    width: 200,
                    child: Card(
                      elevation: 5.0,
                    ),
                  ),
                  baseColor: appDarkSecondaryColor,
                  highlightColor: appDarkBackgroundColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
