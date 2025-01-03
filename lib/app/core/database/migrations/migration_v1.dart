import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_entity_mapper_orm/sqflite_entity_mapper_orm.dart';

class MigrationV1 implements IMigration {
  @override
  void create(Batch batch) {
    batch.execute('''
      create table Users(
        id Integer primary key autoincrement,
        name varchar(100) not null,
        user varchar(100) not null,
        email varchar(100) not null,
        password varchar(500) not null,
        admin bool not null default(0)
      )
    ''');
  }

  @override
  void update(Batch update) {}
}
