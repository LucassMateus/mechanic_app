import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/helpers/functions.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';

class ItemsRegistrationController extends BaseController {
  ItemsRegistrationController() : super(InitialState());

  final List<ItemModel> _filteredItems = [];
  final List<ItemModel> _allItems = [];

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

  void setItems() {
    final newItems = generateItems();
    _allItems.addAll(newItems);
    _filteredItems.addAll(_allItems);
    update(SuccessState(data: _allItems));
  }

  void remove(ItemModel item) {
    _filteredItems.remove(item);
    update(SuccessState(data: _filteredItems));
  }
}
