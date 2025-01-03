import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite_entity_mapper_orm/sqflite_entity_mapper_orm.dart';

import 'database/app_db_context.dart';

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
  void configure() async {
    DataBaseConfig.initialize(
      name: 'CAR_MECHANIC_DB_DEV',
      // name: 'CAR_MECHANIC_DB_DEV',
      version: 1,
      migrations: [
        // MigrationV1(),
        // MigrationV2(),
        // MigrationV3(),
        // MigrationV4(),
      ],
    );

    // final cnx = SqliteDbConnection.get();
    // await cnx.applyMigrations();

    WidgetsBinding.instance.addObserver(SqliteAdmConnection.i);

    final dbContext = Modular.get<AppDbContext>();
    dbContext.initialize();

    // await MigrationManager.applyMigrations(
    //   SqliteDbConnection.get(),
    //   dbContext.dbSets.map((e) => e.dbEntity).toList(),
    // );
  }

  @override
  void initState() {
    configure();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(SqliteAdmConnection.i);
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
