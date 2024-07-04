import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';

abstract interface class IItemRepository {
  Future<List<ItemModel>> getItems();

  Future<void> update(ItemModel item);
  Future<void> save(int code, String description, double cost);
  Future<void> delete(int code);

}