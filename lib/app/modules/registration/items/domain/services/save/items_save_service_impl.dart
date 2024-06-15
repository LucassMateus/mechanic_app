import 'package:mechanic_app/app/modules/registration/items/infra/repositories/i_item_repository.dart';

import './i_items_save_service.dart';

class ItemsSaveServiceImpl implements IItemsSaveService {
  ItemsSaveServiceImpl({required IItemRepository repository})
      : _repository = repository;

  final IItemRepository _repository;

  @override
  Future<void> call(int code, String description, double cost) async =>
      await _repository.save(code, description, cost);
}
