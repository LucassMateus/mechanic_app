import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';

abstract interface class IItemsUpdateService {
  Future<void> call(ItemModel item);
}