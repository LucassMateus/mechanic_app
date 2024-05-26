import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/core/mechanic_core_config.dart';

void main() {
  runApp(ModularApp(module: CoreModule(), child: const MechanicCoreConfig(title: 'Mechanic App')));
}

