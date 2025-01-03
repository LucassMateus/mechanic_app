import 'package:mechanic_app/app/core/database/app_db_context.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import 'package:sqflite_entity_mapper_orm/sqflite_entity_mapper_orm.dart';

class CarsLocalDAO extends SqliteGenericRepository<CarModel> {
  CarsLocalDAO({required AppDbContext dbContext})
      : super(dbSet: dbContext.cars);

  Future<List<CarModel>> getAll() async => super.dbSet.findAll();
  Future<List<CarModel>> getById(int id) async =>
      super.dbSet.findAll('id = ?', [id]);

  //Somente para teste
  Future<void> removeById(int id) async {
    final result = await super //
        .dbSet
        .query
        .select()
        .join('Customers c', onClause: 'x.customerID = c.id')
        .where('c.id = $id')
        .and()
        .between('x.id', '5', '10')
        .execute();

    final carsToRemove = result.entities;

    for (final car in carsToRemove) {
      await super.remove(car);
    }
  }
}
