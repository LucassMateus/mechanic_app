import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/controllers/base_controller.dart';

abstract class BaseStatePage<T extends StatefulWidget, C extends BaseController>
    extends State<T> {
  final C controller = Modular.get<C>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.addListener(listener);
      await onReady();
    });
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    onClose();
    super.dispose();
  }

  FutureOr<void> onReady() {}

  void onClose() {}

  void listener() {}
}
