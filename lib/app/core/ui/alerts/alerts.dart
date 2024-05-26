import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/ui/components/alert_widget.dart';

class Alerts {
  static void showSuccess(BuildContext context, String message) {
    SnackBar snackBar = AlertWidget(
      color: Colors.white,
      backgroundColor: Theme.of(context).colorScheme.primary,
      // imageIcon: CooIcons.cooCheck,
      message: message,
    ).build(context);

    show(context, snackBar);
  }

  static void showFailure(BuildContext context, String message) {
    SnackBar snackBar = AlertWidget(
      color: Colors.white,
      backgroundColor: Theme.of(context).colorScheme.error,
      // icon: CooIcons.cooCrossCircle,
      message: message,
    ).build(context);

    show(context, snackBar);
  }

  static void show(BuildContext context, SnackBar snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}