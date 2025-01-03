import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_entity_mapper_orm/sqflite_entity_mapper_orm.dart';

class MigrationV4 implements IMigration {
  @override
  void create(Batch batch) {}

  @override
  void update(Batch update) {
    update.execute('''
    CREATE TABLE IF NOT EXISTS Services_new (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT
    )
  ''');

    update.execute('DROP TABLE Services;');

    update.execute('ALTER TABLE Services_new RENAME TO Services;');

    update.execute('''
      CREATE TABLE IF NOT EXISTS ServicesItems (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        serviceId INTEGER NOT NULL,
        itemId INTEGER NOT NULL,
        FOREIGN KEY (serviceId) REFERENCES Services(id) ON DELETE CASCADE,
        FOREIGN KEY (itemId) REFERENCES Items(id) ON DELETE CASCADE
      )
    ''');

    update.execute('''
      CREATE TABLE IF NOT EXISTS ServicesCars (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        serviceId INTEGER NOT NULL,
        carId INTEGER NOT NULL,
        FOREIGN KEY (serviceId) REFERENCES Services(id) ON DELETE CASCADE,
        FOREIGN KEY (carId) REFERENCES Cars(id) ON DELETE CASCADE
      )
    ''');
  }
}
