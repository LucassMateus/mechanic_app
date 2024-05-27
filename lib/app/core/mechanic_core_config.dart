import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MechanicCoreConfig extends StatelessWidget {
  const MechanicCoreConfig({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Modular.routerConfig,
      title: title,
      debugShowCheckedModeBanner: false,
    );
  }
}
