import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/services/get/i_customer_get_service.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/services/remove/i_customer_remove_service.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/services/save/i_customer_save_service.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/services/update/i_customer_update_service.dart';

import '../../domain/models/customer_model.dart';

class CostumerRegistrationController extends BaseController {
  CostumerRegistrationController({
    required ICustomerGetService getService,
    required ICustomerSaveService saveService,
    required ICustomerRemoveService removeService,
    required ICustomerUpdateService updateService,
  })  : _getService = getService,
        _saveService = saveService,
        _removeService = removeService,
        _updateService = updateService,
        super(InitialState());

  final ICustomerGetService _getService;
  final ICustomerSaveService _saveService;
  final ICustomerRemoveService _removeService;
  final ICustomerUpdateService _updateService;

  final List<CustomerModel> _costumers = [];
  final List<CustomerModel> _filteredCostumers = [];

  Future<void> getCustomers() async {
    try {
      final result = await _getService.call();
      _costumers.addAll(result);
      update(SuccessState(data: _costumers));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  Future<void> removeCostumer(CustomerModel costumer) async {
    try {
      await _removeService.call(costumer.id);
      _costumers.remove(costumer);
      _filteredCostumers.remove(costumer);

      update(SuccessState(data: _filteredCostumers));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  Future<void> saveCostumer(
      String name, String emailAddress, String phone) async {
    try {
      await _saveService.call(name, emailAddress, phone);
      final customers = await _getService.call();
      _costumers.clear();
      _costumers.addAll(customers);

      update(SuccessState(data: _costumers));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  Future<void> updateCostumer(
      int id, String name, String emailAddress, String phone) async {
    try {
      final updatedCostumer = CustomerModel(
          id: id, name: name, phoneNumber: phone, email: emailAddress);
      await _updateService.call(updatedCostumer);
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
