import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:mechanic_app/app/modules/registration/items/infra/repositories/i_item_repository.dart';

import './i_items_update_service.dart';

class ItemsUpdateServiceImpl implements IItemsUpdateService {
      ItemsUpdateServiceImpl({required IItemRepository repository}) : _repository = repository;

  final IItemRepository _repository;
  
  @override
  Future<void> call(ItemModel item) async => await _repository.update(item);
}