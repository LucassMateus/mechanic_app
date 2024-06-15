import 'package:mechanic_app/app/core/database/sqlite_connection_factory.dart';
import 'package:mechanic_app/app/core/exceptions/repository_exception.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:mechanic_app/app/modules/registration/items/infra/repositories/i_item_repository.dart';

class ItemDataBaseRepositoryImpl implements IItemRepository {
  ItemDataBaseRepositoryImpl({required SqliteConnectionFactory dbFactory})
      : _dbFactory = dbFactory;

  final SqliteConnectionFactory _dbFactory;

  @override
  Future<void> delete(int code) async {
    try {
      final connection = await _dbFactory.openConnection();
      await connection.rawDelete('DELETE FROM Items WHERE code = ?', [code]);
    } catch (e) {
      throw RepositoryException(
          message: 'Erro ao excluir carro. ${e.toString()}');
    }
  }

  @override
  Future<List<ItemModel>> getItems() async {
    try {
      final connection = await _dbFactory.openConnection();
      final queryResult = await connection.rawQuery('''select * from Items''');

      final items = queryResult.map((e) => ItemModel.fromMap(e)).toList();
      return items;
    } catch (e) {
      throw RepositoryException(
          message: 'Erro ao buscar os itens salvos. ${e.toString()}');
    }
  }

  @override
  Future<void> save(int code, String description, double cost) async {
    try {
      final connection = await _dbFactory.openConnection();
      await connection.insert('Items', {
        'code': code,
        'description': description,
        'cost': cost,
      });
    } catch (e) {
      throw RepositoryException(
          message: 'Erro ao salvar item. ${e.toString()}');
    }
  }

  @override
  Future<void> update(ItemModel item) async {
    try {
      final connection = await _dbFactory.openConnection();
      await connection.rawUpdate('''UPDATE Items 
                                    SET description = ?, 
                                        cost = ? 
                                    WHERE code = ?''',
          [item.description, item.cost, item.code]);
    } catch (e) {
      throw RepositoryException(
          message: 'Erro ao atualizar item. ${e.toString()}');
    }
  }
}
