import 'package:mechanic_app/app/core/database/sqlite_connection_factory.dart';
import 'package:mechanic_app/app/core/exceptions/repository_exception.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';

import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';

import 'package:mechanic_app/app/modules/registration/services/domain/models/service_model.dart';

import 'i_services_repository.dart';

class ServicesDataBaseRepositoryImpl implements IServicesRepository {
  ServicesDataBaseRepositoryImpl({required SqliteConnectionFactory dbFactory})
      : _dbFactory = dbFactory;

  final SqliteConnectionFactory _dbFactory;
  @override
  Future<void> delete(int id) async {
    try {
      final connection = await _dbFactory.openConnection();
      await connection.rawDelete('DELETE FROM Services WHERE id = ?', [id]);
    } catch (e) {
      throw RepositoryException(
          message: 'Erro ao excluir serviço. ${e.toString()}');
    }
  }

  @override
  Future<List<ServiceModel>> getAll() async {
    try {
      final connection = await _dbFactory.openConnection();
      final response = await connection.rawQuery('''SELECT * FROM Services''');

      final result = response.map((e) => ServiceModel.fromMap(e)).toList();
      return result;
    } catch (e) {
      throw RepositoryException(
          message: 'Erro ao buscar serviços. ${e.toString()}');
    }
  }

  @override
  Future<void> save(String name, String description, int hoursAmount,
      List<ItemModel> items, Map<CarModel, double> pricePerCar) async {
    try {
      final connection = await _dbFactory.openConnection();
      await connection.insert('Services', {
        'name': name,
        'description': description,
        'quantity_hours': hoursAmount,
        // 'items': items,
        // 'pricePerCar': pricePerCar,
      });
    } catch (e) {
      throw RepositoryException(
          message: 'Erro ao salvar serviço. ${e.toString()}');
    }
  }

  @override
  Future<void> update(ServiceModel service) async {
    try {
      final connection = await _dbFactory.openConnection();
      await connection.rawUpdate('''UPDATE Services 
                                    SET name = ?, 
                                        description = ?,
                                        quantity_hours = ?
                                    WHERE id = ?''',
          [service.name, service.description, service.hoursAmount, service.id]);
    } catch (e) {
      throw RepositoryException(
          message: 'Erro ao atualizar serviço. ${e.toString()}');
    }
  }
}
