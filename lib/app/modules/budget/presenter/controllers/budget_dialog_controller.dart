import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/services/get/i_items_get_service.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/models/service_model.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/get_all/i_services_get_all_service.dart';
import '../../../registration/customers/domain/models/customer_model.dart';
import '../../../registration/customers/domain/services/get/i_customer_get_service.dart';
import '../../../registration/items/domain/models/item_model.dart';

class BudgetDialogController extends BaseController {
  BudgetDialogController({
    required ICustomerGetService getCustomersService,
    required IServicesGetallService getServicesGetallService,
    required IItemsGetService getItemsGetService,
  })  : _getCustomersService = getCustomersService,
        _getServicesGetallService = getServicesGetallService,
        _getItemsGetService = getItemsGetService,
        super(InitialState());

  final ICustomerGetService _getCustomersService;
  final IServicesGetallService _getServicesGetallService;
  final IItemsGetService _getItemsGetService;

  final List<CustomerModel> _customers = [];
  List<CustomerModel> get customers => _customers;
  final List<ServiceModel> _services = [];
  List<ServiceModel> get services => _services;
  final List<ItemModel> _items = [];
  List<ItemModel> get items => _items;

  CustomerModel? _selectedCustomer;
  CustomerModel? get selectedCustomer => _selectedCustomer;
  CarModel? _selectedCar;
  CarModel? get selectedCar => _selectedCar;

  Future<void> fetchData() async {
    try {
      update(LoadingState());

      await Future.delayed(const Duration(seconds: 2));
      final customers = await _getCustomersService.call();
      final services = await _getServicesGetallService.call();
      final items = await _getItemsGetService.call();

      _clearAll();
      _services.addAll(services);
      _items.addAll(items);
      _customers.addAll(customers);

      update(const SuccessState(data: []));
    } on Exception catch (e) {
      update(ErrorState(exception: Exception(e)));
    }
  }

  void setCustomer(CustomerModel? customer) => _selectedCustomer = customer;

  void setCar(CarModel? car) => _selectedCar = car;

  void _clearAll() {
    _customers.clear();
    _services.clear();
    _items.clear();
  }
}
