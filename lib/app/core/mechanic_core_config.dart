import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/database/sqlite_adm_connection.dart';

class MechanicCoreConfig extends StatefulWidget {
  const MechanicCoreConfig({
    required this.title,
    super.key,
  });

  final String title;

  @override
  State<MechanicCoreConfig> createState() => _MechanicCoreConfigState();
}

class _MechanicCoreConfigState extends State<MechanicCoreConfig> {
  final SqliteAdmConnection sqliteAdmConnection =
      Modular.get<SqliteAdmConnection>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(sqliteAdmConnection);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(sqliteAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Modular.routerConfig,
      title: widget.title,
      debugShowCheckedModeBanner: false,
    );
  }
}
