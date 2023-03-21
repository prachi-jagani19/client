import 'package:client/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// ------------------------------------------------------------------- ///
/// FONT WEIGHT
class FontWeightClass {
  static const light = FontWeight.w200;
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiB = FontWeight.w600;
  static const bold = FontWeight.w700;
  static const extraB = FontWeight.w800;
  static const black = FontWeight.w900;
}

/// ------------------------------------------------------------------- ///
/// FONT TEXT STYLE

class FontTextStyle {
  static TextStyle Proxima24Medium = TextStyle(
    fontFamily: 'ProximaNova',
    fontSize: 20.sp,
    color: ColorUtils.primaryColor,
    fontWeight: FontWeightClass.medium,
  );
  static TextStyle Proxima14Regular = TextStyle(
    fontFamily: 'ProximaNova',
    fontSize: 11.sp,
    fontWeight: FontWeightClass.regular,
  );
  static TextStyle Proxima12Regular = TextStyle(
    fontFamily: 'ProximaNova',
    fontSize: 9.sp,
    fontWeight: FontWeightClass.regular,
  );
  static TextStyle Proxima10Regular = TextStyle(
    fontFamily: 'ProximaNova',
    fontSize: 10.sp,
    fontWeight: FontWeightClass.regular,
  );
  static TextStyle Proxima16Medium = TextStyle(
    fontFamily: 'ProximaNova',
    fontSize: 12.sp,
    fontWeight: FontWeightClass.medium,
  );
}
