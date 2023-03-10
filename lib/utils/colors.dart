import 'package:flutter/material.dart';

const ColorPrimary = Color(0xff844cc6);
const ColorTextPrimary = Color(0xff555555);
const ColorTextFeild = Color(0xfff2f2f2);
const ApproveTextBgColor = Color(0xffc6e5ba);
const ApproveTextColor = Color(0xff41a81b);

const RejectedTextBgColor = Color(0xfff8b2b2);
const RejectedTextColor = Color(0xffec3b3b);

const PendingTextBgColor = Color(0xfffcdfc7);
const PendingTextColor = Color(0xfff69444);

const DirectBillTextBgColor = Color(0xffcadafa);
const DirectBillingTextColor = Color(0xff5086ed);

const RejectedBoxBgColor = Color(0xffecc9c9);
const RejectedBoxTextColor = Color(0xffbe1919);

const GreenBoxBgColor = Color(0xffc6e5ba);
const GreenBoxTextColor = Color(0xff41a81b);

// Gradient Colors

const RedLightColor = Color(0xffec4b4b);
const RedDarkColor = Color(0xffbe1919);

const GreenLightColor = Color(0xff5ecb35);
const GreenDarkColor = Color(0xff41a81b);

const PurpleLightColor = Color(0xff8e82ff);
const PurpleDarkColor = Color(0xff6657f4);

class CustomColors {
  static Color primaryTextColor = Colors.white;
  static Color dividerColor = Colors.white54;
  static Color pageBackgroundColor = Color(0xFF2D2F41);
  static Color menuBackgroundColor = Color(0xFF242634);
  static Color lightGolden = Color(0xFFd6ac45);
  static Color darkGolden = Color(0xFFc3822d);

  static Color clockBG = Color(0xFF444974);
  static Color clockOutline = Color(0xFFEAECFF);
  static Color secHandColor = Colors.orange;
  static Color minHandStatColor = Color(0xFF748EF6);
  static Color minHandEndColor = Color(0xFF77DDFF);
  static Color hourHandStatColor = Color(0xFFC279FB);
  static Color hourHandEndColor = Color(0xFFEA74AB);
}

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
  static List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
  static List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
  static List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
  static List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
  static List<Color> theme = [Color(0xFFc663ff), Color(0xFFc084e3)];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
    GradientColors(GradientColors.theme),
  ];
}
