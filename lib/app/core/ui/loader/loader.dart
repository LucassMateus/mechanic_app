import 'package:flutter/material.dart';

mixin Loader<T extends StatefulWidget> on State<T> {
  bool isOpen = false;

  showLoader() {
    if (!isOpen) {
      isOpen = true;
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          });
    }
  }

  hideLoader() {
    if (isOpen) {
      isOpen = false;
      Navigator.of(context).pop();
    }
  }
}
