import 'package:mechanic_app/app/core/database/migrations/i_migration.dart';
import 'package:mechanic_app/app/core/database/migrations/migration_v1.dart';

class SqliteMigrationFactory {
  List<IMigration> getCreateMigration() => [
        MigrationV1(),
      ];

  List<IMigration> getUpgradeMigration(int version) {
    final migrations = getCreateMigration().sublist(version);

    return migrations;
  }
}
