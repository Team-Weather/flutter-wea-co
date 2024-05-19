import 'package:flutter/material.dart';

/// 반응형으로 크기를 넣고 싶을 때 사용합니다.
/// @param[marginHeight], @param[marginWidth]에 입력한 수치는 디바이스의 길이 대비 비율로 계산됩니다.
class ReactionUtil {
  static double reactHeight(
      {required BuildContext context, required double marginHeight}) {
    double screenHeight = MediaQuery.of(context).size.height;
    double heightPercentage = marginHeight / screenHeight;
    return screenHeight * heightPercentage;
  }

  static double reactWidth(
      {required BuildContext context, required double marginWidth}) {
    double screenWidth = MediaQuery.of(context).size.width;
    double widthPercentage = marginWidth / screenWidth;
    return screenWidth * widthPercentage;
  }
}
