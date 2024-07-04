import 'package:sqflite_common/sqlite_api.dart';

import 'i_migration.dart';

class MigrationV1 implements IMigration {
  @override
  void create(Batch batch) {
    batch.execute('''
      create table user(
        id Integer primary key autoincrement,
        name varchar(100) not null,
        userName varchar(100) not null,
        email varchar(100) not null,
        password varchar(500) not null,
        admin bool
      )
    ''');
  }

  @override
  void update(Batch update) {}
}