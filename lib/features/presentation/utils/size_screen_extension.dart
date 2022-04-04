import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizeScreenExtension on num {
  double get w => ScreenUtil().setWidth(this);
  double get h => ScreenUtil().setHeight(this);
  double get sp => ScreenUtil().setSp(this);
  double get sw => ScreenUtil().screenWidth * this;
  double get sh => ScreenUtil().screenWidth * this;
  double get statusBarHeight => ScreenUtil().statusBarHeight * this;
}
