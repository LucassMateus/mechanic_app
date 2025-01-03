import 'package:flutter/material.dart';

import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/repositories/i_item_repository.dart';
import 'package:mechanic_app/app/modules/registration/items/external/data_sources/items_local_dao.dart';

class ItemDataBaseRepositoryImpl implements IItemRepository {
  ItemDataBaseRepositoryImpl({required this.localDao});

  @protected
  final ItemsLocalDao localDao;

  @override
  Future<void> delete(ItemModel item) async => localDao.remove(item);

  @override
  Future<List<ItemModel>> getItems() async => localDao.getAll();

  @override
  Future<void> save(ItemModel item) async => localDao.save(item);

  @override
  Future<void> update(ItemModel item) async => localDao.update(item);
}
