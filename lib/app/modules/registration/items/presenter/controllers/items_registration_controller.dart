import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/helpers/functions.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/services/get/i_items_get_service.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/services/remove/i_items_remove_service.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/services/save/i_items_save_service.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/services/update/i_items_update_service.dart';

class ItemsRegistrationController extends BaseController {
  ItemsRegistrationController({
    required IItemsGetService getService,
    required IItemsSaveService saveService,
    required IItemsRemoveService removeService,
    required IItemsUpdateService updateService,
  })  : _getService = getService,
        _saveService = saveService,
        _removeService = removeService,
        _updateService = updateService,
        super(InitialState());

  final IItemsGetService _getService;
  final IItemsSaveService _saveService;
  final IItemsRemoveService _removeService;
  final IItemsUpdateService _updateService;

  final List<ItemModel> _allItems = [];
  final List<ItemModel> _filteredItems = [];

  Future<void> getItems() async {
    update(LoadingState());
    try {
      _clearAll();

      final items = await _getService.call();

      _allItems.addAll(items);
      _filteredItems.addAll(items);

      update(SuccessState(data: _filteredItems));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  Future<void> removeItem(ItemModel item) async {
    update(LoadingState());
    try {
      await _removeService.call(item.code);
      _allItems.remove(item);
      _filteredItems.remove(item);
      update(SuccessState(data: _filteredItems));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  Future<void> saveItem(int code, String description, double cost) async {
    update(LoadingState());
    try {
      await _saveService.call(code, description, cost);
      await getItems();

      update(SuccessState(data: _filteredItems));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  Future<void> updateItem(int code,
      String description, double cost) async {
    update(LoadingState());
    try {
      final updatedItem =
          ItemModel(code: code, description: description, cost: cost);
      await _updateService.call(updatedItem);
      await getItems();

      update(SuccessState(data: _filteredItems));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  void filterItems(String filterValue) {
    if (filterValue.isEmpty) {
      _filteredItems.addAll(_allItems);
    } else {
      _filteredItems.addAll(_allItems
          .where((item) => item.description.toLowerCase().contains(
                filterValue.toLowerCase(),
              ))
          .toList());
    }
    update(SuccessState(data: _filteredItems));
  }

  void _clearAll() {
    _allItems.clear();
    _filteredItems.clear();
  }

}
