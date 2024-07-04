import 'package:mechanic_app/app/core/database/sqlite_connection_factory.dart';
import 'package:mechanic_app/app/core/exceptions/repository_exception.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';

import './i_car_repository.dart';

class CarDataBaseRepositoryImpl implements ICarRepository {
  CarDataBaseRepositoryImpl({required SqliteConnectionFactory dbFactory})
      : _dbFactory = dbFactory;

  final SqliteConnectionFactory _dbFactory;

  @override
  Future<List<CarModel>> getCars() async {
    try {
      final connection = await _dbFactory.openConnection();
      final queryResult = await connection.rawQuery('''select * from Cars''');

      final cars = queryResult.map((e) => CarModel.fromMap(e)).toList();
      return cars;
    } catch (e) {
      throw RepositoryException(
          message: 'Erro ao buscar os carros salvos. ${e.toString()}');
    }
  }

  @override
  Future<void> save(String model, String brand, int year) async {
    try {
      final connection = await _dbFactory.openConnection();
      await connection.insert('Cars', {
        'model': model,
        'brand': brand,
        'year': year,
      });
    } catch (e) {
      throw RepositoryException(
          message: 'Erro ao salvar carro. ${e.toString()}');
    }
  }

  @override
  Future<void> remove(int id) async {
    try {
      final connection = await _dbFactory.openConnection();
      await connection.rawDelete('DELETE FROM Cars WHERE id = ?', [id]);
    } catch (e) {
      throw RepositoryException(
          message: 'Erro ao excluir carro. ${e.toString()}');
    }
  }

  @override
  Future<void> update(CarModel car) async {
    try {
      final connection = await _dbFactory.openConnection();
      await connection.rawUpdate('''UPDATE Cars 
                                    SET model = ?, 
                                        brand = ?, 
                                        year = ?
                                    WHERE id = ?''',
          [car.model, car.brand, car.year, car.id]);
    } catch (e) {
      throw RepositoryException(
          message: 'Erro ao atualizar carro. ${e.toString()}');
    }
  }
}
