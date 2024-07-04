import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/helpers/functions.dart';
import 'package:mechanic_app/app/modules/service_order/domain/models/service_order.dart';

class ServiceOrdersController extends BaseController {
  ServiceOrdersController() : super(InitialState());

  List<ServiceOrderModel> _filteredServiceOrders = [];
  final List<ServiceOrderModel> _allServiceOrders = [];

  void getServiceOrders() {
    final newServiceOrders = generateServiceOrders(10);
    _allServiceOrders.addAll(newServiceOrders);
    _filteredServiceOrders.addAll(newServiceOrders);
    update(SuccessState(data: _allServiceOrders));
  }

  void filterByStatus(String? status) {
    if (status == null) {
      _filteredServiceOrders = _allServiceOrders;
    } else {
      _filteredServiceOrders = _allServiceOrders
          .where((budget) => budget.status.name == status)
          .toList();
    }
    update(SuccessState(data: _filteredServiceOrders));
  }
}
