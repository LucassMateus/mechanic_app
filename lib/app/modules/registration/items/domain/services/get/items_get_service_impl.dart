import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:mechanic_app/app/modules/registration/items/infra/repositories/i_item_repository.dart';

import './i_items_get_service.dart';

class ItemsGetServiceImpl implements IItemsGetService {
    ItemsGetServiceImpl({required IItemRepository repository}) : _repository = repository;

  final IItemRepository _repository;
  @override
  Future<List<ItemModel>> call() async => await _repository.getItems();

}