import 'package:mechanic_app/app/modules/registration/items/infra/repositories/i_item_repository.dart';

import './i_items_remove_service.dart';

class ItemsRemoveServiceImpl implements IItemsRemoveService {
      ItemsRemoveServiceImpl({required IItemRepository repository}) : _repository = repository;

  final IItemRepository _repository;
  @override
  Future<void> call(int code) async => await _repository.delete(code);

}