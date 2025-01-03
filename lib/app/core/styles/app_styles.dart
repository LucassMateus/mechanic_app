import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/styles/text_styles.dart';

import 'colors_app.dart';

class AppStyles {
  static AppStyles? _i;

  AppStyles._();

  static AppStyles get i => _i ??= AppStyles._();

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
        textStyle: TextStyles.i.textRegular.copyWith(
          color: Colors.white,
        ),
        backgroundColor: ColorsApp.i.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      );

  ButtonStyle get secondaryButton => ElevatedButton.styleFrom(
        textStyle: TextStyles.i.textRegular.copyWith(
          color: ColorsApp.i.primary,
        ),
        backgroundColor: ColorsApp.i.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      );

  ButtonStyle get primaryTextButton => TextButton.styleFrom(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        backgroundColor: ColorsApp.i.primary,
      );
  ButtonStyle get secondaryTextButton => TextButton.styleFrom(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        backgroundColor: ColorsApp.i.secondary,
      );
}

extension AppStylesExtension on BuildContext {
  AppStyles get appStyles => AppStyles.i;
}
