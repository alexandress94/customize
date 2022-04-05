import 'package:flutter/widgets.dart';

import 'package:lottie/lottie.dart';

import '../contracts/lottie_adapter.dart';

class LottieAdapterImplementation implements LottieAdapter {
  @override
  Widget asset({
    required String path,
    double? width,
    double? height,
  }) =>
      Lottie.asset(
        path,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        frameRate: FrameRate.max,
        width: width,
        height: height,
      );
}
