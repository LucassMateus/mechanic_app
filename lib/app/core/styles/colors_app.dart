import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;

  ColorsApp._();

  static ColorsApp get i => _instance ??= ColorsApp._();

  Color get primary => const Color.fromRGBO(108, 82, 171, 1);
  Color get secondary => const Color.fromRGBO(240, 239, 244, 1);
}

extension ColorsAppExtension on BuildContext {
  ColorsApp get colors => ColorsApp.i;
}
