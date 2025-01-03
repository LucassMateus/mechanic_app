import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:sqflite_entity_mapper_orm/sqflite_entity_mapper_orm.dart';

import '../../../../../core/database/app_db_context.dart';

class ItemsLocalDao extends SqliteGenericRepository<ItemModel> {
  ItemsLocalDao({required AppDbContext dbContext})
      : super(dbSet: dbContext.items);

  Future<List<ItemModel>> getAll() async => await super.dbSet.findAll();
}
