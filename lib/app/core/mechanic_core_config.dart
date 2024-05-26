import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MechanicCoreConfig extends StatelessWidget {
  const MechanicCoreConfig({
    required this.title,
    // required this.initalroute,
    // required this.theme,
    // required this.pages,
    // this.translations,
    super.key,
  });

  final String title;
  // final ThemeData theme;
  // final String initalroute;
  // final List<GetPage<dynamic>>? pages;
  // final Translations? translations;
  // final Bindings? bindings;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Modular.routerConfig,
      title: title,
      debugShowCheckedModeBanner: false,
    );
  }
}
