import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';

import '../../../../../helpers/functions.dart';
import '../../domain/models/customer_model.dart';

class CostumerRegistrationController extends BaseController {
  CostumerRegistrationController() : super(InitialState());

  final List<CustomerModel> _costumers = [];
  final List<CustomerModel> _filteredCostumers = [];

  void getCosumers() {
    final newCostumers = generateCustomers(15);
    _costumers.addAll(newCostumers);
    _filteredCostumers.addAll(_costumers);

    update(SuccessState(data: _costumers));
  }

  void filterCostumer(String filterValue) {
    _filteredCostumers.clear();
    // final List<CustomerModel> filteredCostumers = [];
    if (filterValue.isEmpty) {
      _filteredCostumers.addAll(_costumers);
    } else {
      _filteredCostumers.addAll(_costumers
          .where((item) => item.name.toLowerCase().contains(
                filterValue.toLowerCase(),
              ))
          .toList());
    }
    update(SuccessState(data: _filteredCostumers));
  }

  void removeCostumer(CustomerModel costumer) {
    _costumers.remove(costumer);
    _filteredCostumers.remove(costumer);
    update(SuccessState(data: _filteredCostumers));
  }
}
