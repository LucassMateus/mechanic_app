import 'package:flutter/material.dart';

class TextStyles {
  static TextStyles? _instance;

  TextStyles._();

  static TextStyles get i => _instance ??= TextStyles._();

  TextStyle get textLight => const TextStyle(fontWeight: FontWeight.w300);
  TextStyle get textRegular => const TextStyle(fontWeight: FontWeight.normal);
  TextStyle get textMedium => const TextStyle(fontWeight: FontWeight.w500);
  TextStyle get textSemiBold => const TextStyle(fontWeight: FontWeight.w600);
  TextStyle get textBold => const TextStyle(fontWeight: FontWeight.bold);
  TextStyle get textExtraBold => const TextStyle(fontWeight: FontWeight.w800);

  TextStyle get textButtonLabel => textBold.copyWith(fontSize: 14);
  TextStyle get textTitle => textExtraBold.copyWith(fontSize: 28);
  TextStyle get appBarTitle => textBold.copyWith(fontSize: 24);
}

extension TextStylesExtension on BuildContext {
  TextStyles get textStyles => TextStyles.i;
}
