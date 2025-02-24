import 'package:flutter/painting.dart';
class FontFamily {
  static const String roboto = 'Roboto';
}

class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}
TextStyle getTextStyle(double size, FontWeight fontWeight, Color color,
    {TextDecoration decoration = TextDecoration.none}) {
  return TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
      fontFamily: FontFamily.roboto,
      color: color,
      decoration: decoration);
}
class AppFontSizes {
  static const double s10 = 10;
  static const double s12 = 12;
  static const double s14 = 14;
  static const double s16 = 16;
  static const double s18 = 18;
  static const double s20 = 20;
  static const double s22 = 22;
  static const double s24 = 24;
  static const double s26 = 26;
  static const double s28 = 28;
}

TextStyle getLightStyle(
    {double size = AppFontSizes.s12,
    required Color color,
    TextDecoration decoration = TextDecoration.none}) {
  return getTextStyle(size, FontWeightManager.light, color,
      decoration: decoration);
}

TextStyle getRegularStyle(
    {double size = AppFontSizes.s12,
    required Color color,
    TextDecoration decoration = TextDecoration.none}) {
  return getTextStyle(size, FontWeightManager.regular, color,
      decoration: decoration);
}

TextStyle getMediumStyle(
    {double size = AppFontSizes.s12,
    required Color color,
    TextDecoration decoration = TextDecoration.none}) {
  return getTextStyle(size, FontWeightManager.medium, color,
      decoration: decoration);
}

TextStyle getSemiBoldStyle(
    {double size = AppFontSizes.s12,
    required Color color,
    TextDecoration decoration = TextDecoration.none}) {
  return getTextStyle(size, FontWeightManager.semiBold, color,
      decoration: decoration);
}

TextStyle getBoldStyle(
    {double size = AppFontSizes.s12,
    required Color color,
    TextDecoration decoration = TextDecoration.none}) {
  return getTextStyle(size, FontWeightManager.bold, color,
      decoration: decoration);
}
