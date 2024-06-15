import 'package:sqflite_common/sqlite_api.dart';

import 'i_migration.dart';

class MigrationV2 implements IMigration {
  @override
  void create(Batch batch) {}

  @override
  void update(Batch update) {
    update.execute('''
      CREATE TABLE Customers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(100) NOT NULL,
        address VARCHAR(100),
        phone VARCHAR(20)
      )
    ''');

    update.execute('''
      CREATE TABLE Cars (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        model VARCHAR(50) NOT NULL,
        brand VARCHAR(50) NOT NULL,
        year INTEGER NOT NULL
      )
    ''');

    update.execute('''
      CREATE TABLE CustomerCars (
        customer_id INTEGER NOT NULL,
        car_id INTEGER NOT NULL,
        PRIMARY KEY (customer_id, car_id),
        FOREIGN KEY (customer_id) REFERENCES Customers(id),
        FOREIGN KEY (car_id) REFERENCES Cars(id)
      )
    ''');

    update.execute('''
      CREATE TABLE Items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code INTEGER NOT NULL,
        description VARCHAR(100),
        cost DECIMAL(10, 2) NOT NULL
      )
    ''');

    update.execute('''
      CREATE TABLE Services (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(50) NOT NULL,
        description VARCHAR(100),
        quantity_hours INTEGER NOT NULL
      )
    ''');

    update.execute('''
      CREATE TABLE CostTypes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(50) NOT NULL
      )
    ''');

    update.execute('''
      CREATE TABLE Costs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cost_type_id INTEGER NOT NULL,
        name VARCHAR(50) NOT NULL,
        value DECIMAL(10, 2) NOT NULL,
        date DATE NOT NULL,
        end_date DATE,
        FOREIGN KEY (cost_type_id) REFERENCES CostTypes(id)
      )
    ''');

    update.execute('''
      CREATE TABLE ServiceOrders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        start_date DATE NOT NULL,
        end_date DATE
      )
    ''');

    update.execute('''
      CREATE TABLE ServiceOrderServices (
        service_order_id INTEGER NOT NULL,
        service_id INTEGER NOT NULL,
        PRIMARY KEY (service_order_id, service_id),
        FOREIGN KEY (service_order_id) REFERENCES ServiceOrders(id),
        FOREIGN KEY (service_id) REFERENCES Services(id)
      )
    ''');

    update.execute('''
      CREATE TABLE ServiceOrderItems (
        service_order_id INTEGER NOT NULL,
        item_id INTEGER NOT NULL,
        PRIMARY KEY (service_order_id, item_id),
        FOREIGN KEY (service_order_id) REFERENCES ServiceOrders(id),
        FOREIGN KEY (item_id) REFERENCES Items(id)
      )
    ''');
  }
}
