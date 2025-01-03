import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/services/get/i_items_get_service.dart';

class ServicePricePerItemController extends BaseController {
  ServicePricePerItemController(this.getItemsService) : super(InitialState());

  @protected
  final IItemsGetService getItemsService;

  final Set<ItemModel> _items = {};
  Set<ItemModel> get items => _items;

  final Set<ItemModel> serviceItems = {};

  Future<void> init(Set<ItemModel> serviceItems) async {
    update(LoadingState());

    _items.clear();
    final items = await getItemsService();
    _items.addAll(items);

    this.serviceItems.clear();
    this.serviceItems.addAll(serviceItems);

    update(SuccessState(data: items));
  }

  void removeItem(ItemModel item) {
    update(LoadingState());

    serviceItems.remove(item);

    update(SuccessState(data: items));
  }
}
