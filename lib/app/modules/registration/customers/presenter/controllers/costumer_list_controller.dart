import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/services/get/i_customer_get_service.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/services/remove/i_customer_remove_service.dart';

import '../../../cars/domain/models/car_model.dart';
import '../../domain/models/customer_model.dart';

class CostumerListController extends BaseController {
  CostumerListController(
    this.getService,
    this.removeService,
  ) : super(InitialState());

  @protected
  final ICustomerGetService getService;
  @protected
  final ICustomerRemoveService removeService;

  final List<CustomerModel> _costumers = [];
  late final List<CustomerModel> _filteredCostumers;

  final List<CarModel> _cars = [];
  List<CarModel> get cars => _cars;

  final selectedCars = <CarModel>[];

  Future<void> init() async {
    await getCustomers();
  }

  Future<void> getCustomers() async {
    try {
      final result = await getService();
      _costumers.addAll(result);
      _filteredCostumers = List.from(_costumers);
      update(SuccessState(data: _costumers));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  void addCostumer(CustomerModel costumer) {
    _costumers.add(costumer);
    _filteredCostumers.add(costumer);

    update(SuccessState(data: _filteredCostumers));
  }

  void updateCostumer(CustomerModel costumer) {
    final customerIdx = _getCustomerIndexFromList(_costumers, costumer);
    _costumers[customerIdx] = costumer;

    final filteredIdx = _getCustomerIndexFromList(_filteredCostumers, costumer);
    _filteredCostumers[filteredIdx] = costumer;

    update(SuccessState(data: _filteredCostumers));
  }

  int _getCustomerIndexFromList(
    List<CustomerModel> list,
    CustomerModel costumer,
  ) {
    return list.indexWhere((item) => item.id == costumer.id);
  }

  Future<void> removeCostumer(CustomerModel costumer) async {
    try {
      await removeService(costumer);
      _costumers.remove(costumer);
      _filteredCostumers.remove(costumer);

      update(SuccessState(
        data: _filteredCostumers,
        message: 'Cliente removido com sucesso',
      ));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  void filterCostumer(String filterValue) {
    _filteredCostumers.clear();

    if (filterValue.isEmpty) {
      _filteredCostumers.addAll(_costumers);
      return;
    }

    _filteredCostumers.addAll(_costumers
        .where((item) => item.name.toLowerCase().contains(
              filterValue.toLowerCase(),
            ))
        .toList());

    update(SuccessState(data: _filteredCostumers));
  }
}
