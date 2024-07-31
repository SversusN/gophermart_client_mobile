import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor appColor = MaterialColor(
    _f3mobilePrimaryValue,
    <int, Color>{
      50: Color(0xFFE3F7FC),
      100: Color(0xFFB7EAF8),
      200: Color(0xFF89DDF4),
      300: Color(0xFF5FCFF0),
      400: Color(0xFF40C4EF),
      500: Color(0xFF26B9EF),
      600: Color(0xFF1DABE0),
      700: Color(0xFF0F98CD),
      800: Color(0xFF0E86BA),
      900: Color(_f3mobilePrimaryValue),
    },
  );
  static const int _f3mobilePrimaryValue = 0xFF006699;

  static const textColorDarkGray = Color(0xFF333333);
  static const textColorGray = Color(0xFF666666);
  static const textColorDisabled = Color.fromARGB(255, 221, 220, 220);
  static const textColorGreen = Color(0xFF007C64);
  static const textColorRed = Color(0xFFD82F36);
  static const mainPageBannerBackgroundColor = Color(0xFFF2F3F7);
  static const textCircleColor = Color(0xFF1B73B0);
  static const gopherColor = Color.fromRGBO(80, 204, 225, 255);
}
