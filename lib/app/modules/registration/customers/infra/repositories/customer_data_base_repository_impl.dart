import 'package:mechanic_app/app/core/database/sqlite_connection_factory.dart';
import 'package:mechanic_app/app/core/exceptions/repository_exception.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/models/customer_model.dart';
import 'i_customer_repository.dart';

class CostumerDataBaseRepositoryImpl implements ICostumerRepository {
    CostumerDataBaseRepositoryImpl({required SqliteConnectionFactory dbFactory})
      : _dbFactory = dbFactory;

  final SqliteConnectionFactory _dbFactory;

  @override
  Future<List<CustomerModel>> getAll() async {
    try {
      final connection = await _dbFactory.openConnection();
      final queryResult = await connection.rawQuery('''select * from Customers''');

      final cars = queryResult.map((e) => CustomerModel.fromMap(e)).toList();
      return cars;
    } catch (e) {
      throw RepositoryException(
          message: 'Erro ao buscar os carros salvos. ${e.toString()}');
    }
  }

  @override
  Future<void> save(String name, String emailAddress, String phone) async {
    try {
      final connection = await _dbFactory.openConnection();
      await connection.insert('Customers', {
        'name': name,
        'address': emailAddress,
        'phone': phone,
      });
    } catch (e) {
      throw RepositoryException(
          message: 'Erro ao salvar cliente. ${e.toString()}');
    }
  }

  @override
  Future<void> remove(int id) async {
    try {
      final connection = await _dbFactory.openConnection();
      await connection.rawDelete('DELETE FROM Customers WHERE id = ?', [id]);
    } catch (e) {
      throw RepositoryException(
          message: 'Erro ao excluir cliente. ${e.toString()}');
    }
  }

  @override
  Future<void> update(CustomerModel customer) async {
    try {
      final connection = await _dbFactory.openConnection();
      await connection.rawUpdate('''UPDATE Customers 
                                    SET name = ?, 
                                        address = ?, 
                                        phone = ?, 
                                    WHERE id = ?''',
          [customer.name, customer.email, customer.phoneNumber, customer.id]);
    } catch (e) {
      throw RepositoryException(
          message: 'Erro ao atualizar dados do cliente. ${e.toString()}');
    }
  }
}
