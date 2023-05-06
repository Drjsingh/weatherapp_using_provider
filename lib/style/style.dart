import 'dart:ui';
import 'package:flutter/material.dart';

abstract class ThemeStyle {
  static const TextStyle whiteText16 = TextStyle(
    fontSize: 16,
    letterSpacing: 0,
    color: Color(0xffFFFFFF),
    fontWeight: FontWeight.w400,
  );

  static const TextStyle whiteText14 = TextStyle(
    fontSize: 14,
    letterSpacing: 0,
    color: Color(0xffFFFFFF),
    fontWeight: FontWeight.w400,
  );
  static const TextStyle whiteText28 = TextStyle(
    fontSize: 28,
    letterSpacing: 0,
    color: Color(0xffFFFFFF),
    fontWeight: FontWeight.w400,
  );
  static const TextStyle whiteText35 = TextStyle(
    fontSize: 45,
    letterSpacing: 0,
    color: Color(0xffFFFFFF),
    fontWeight: FontWeight.w400,
  );

  static const TextStyle blackText28 = TextStyle(
    fontSize: 28,
    letterSpacing: 0,
    color: Color(0xff111111),
    fontWeight: FontWeight.w400,
  );
}
