import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';

abstract interface class IItemsGetService {
  Future<List<ItemModel>> call();

}