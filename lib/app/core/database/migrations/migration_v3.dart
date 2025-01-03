import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_entity_mapper_orm/sqflite_entity_mapper_orm.dart';

class MigrationV3 implements IMigration {
  @override
  void create(Batch batch) {}

  @override
  void update(Batch update) {
    // update.execute('''DROP TABLE IF EXISTS CustomersCarsModel;''');

    update.execute('''
      CREATE TABLE IF NOT EXISTS CustomersCarsModel (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customerId INTEGER NOT NULL,
        carId INTEGER NOT NULL,
        FOREIGN KEY (customerId) REFERENCES Customers(id) ON DELETE CASCADE,
        FOREIGN KEY (carId) REFERENCES Cars(id) ON DELETE CASCADE
      )
    ''');
  }
}
