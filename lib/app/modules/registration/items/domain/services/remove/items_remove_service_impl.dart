import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';

import '../../repositories/i_item_repository.dart';
import './i_items_remove_service.dart';

class ItemsRemoveServiceImpl implements IItemsRemoveService {
  ItemsRemoveServiceImpl({required IItemRepository repository})
      : _repository = repository;

  final IItemRepository _repository;
  @override
  Future<void> call(ItemModel item) async => _repository.delete(item);
}
