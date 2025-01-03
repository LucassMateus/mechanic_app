import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_entity_mapper_orm/sqflite_entity_mapper_orm.dart';

class MigrationV2 implements IMigration {
  @override
  void create(Batch batch) {}

  @override
  void update(Batch update) {
    update.execute('''
      CREATE TABLE IF NOT EXISTS Customers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(100) NOT NULL,
        address VARCHAR(100),
        phone VARCHAR(20)
      )
    ''');

    update.execute('''
      CREATE TABLE IF NOT EXISTS Cars (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        model VARCHAR(50) NOT NULL,
        brand VARCHAR(50) NOT NULL,
        year INTEGER NOT NULL
      )
    ''');

    update.execute('''
      CREATE TABLE IF NOT EXISTS Items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code INTEGER NOT NULL,
        description VARCHAR(100),
        cost DECIMAL(10, 2) NOT NULL
      )
    ''');

    update.execute('''
      CREATE TABLE IF NOT EXISTS Services (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(50) NOT NULL,
        description VARCHAR(100),
        quantity_hours INTEGER NOT NULL
      )
    ''');
  }
}
