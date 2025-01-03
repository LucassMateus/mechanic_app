import 'package:mechanic_app/app/core/database/app_db_context.dart';
import 'package:mechanic_app/app/core/database/migrations/migration_v1.dart';
import 'package:mechanic_app/app/core/database/migrations/migration_v2.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_entity_mapper_orm/sqflite_entity_mapper_orm.dart';

class SqliteDatabaseTestConfig {
  late AppDbContext dbContext;

  SqliteDatabaseTestConfig() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    DataBaseConfig.initialize(
      name: 'CAR_MECHANIC_DB_DEV',
      version: 2,
      migrations: [
        MigrationV1(),
        MigrationV2(),
      ],
    );
    // dbContext = AppDbContext();
    // dbContext.initialize();
  }
}
