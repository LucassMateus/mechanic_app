import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';

abstract interface class IItemRepository {
  Future<List<ItemModel>> getItems();
  Future<void> update(ItemModel item);
  Future<void> save(ItemModel item);
  Future<void> delete(ItemModel item);
}
