import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/modules/budget/presenter/controllers/budgets_controller.dart';
import 'package:mechanic_app/app/modules/budget/presenter/pages/budgets_page.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/repositories/i_car_repository.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/services/get_by_customer/i_cars_get_by_customer_service.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/services/remove/car_remove_service_impl.dart';
import 'package:mechanic_app/app/modules/registration/cars/external/data_sources/car_local_dao.dart';
import 'package:mechanic_app/app/modules/registration/customers/external/data_sources/customers_local_dao.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/services/get/items_get_service_impl.dart';
import 'package:mechanic_app/app/modules/registration/items/external/data_sources/items_local_dao.dart';
import 'package:mechanic_app/app/modules/registration/items/infra/repositories/item_data_base_repository_impl.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/get_all/services_get_all_impl.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/repositories/i_services_repository.dart';
import 'package:mechanic_app/app/modules/registration/services/external/data_sources/services_local_dao.dart';
import 'package:mechanic_app/app/modules/registration/services/infra/repositories/services_data_base_repository_impl.dart';

import '../registration/customers/domain/repositories/i_customer_repository.dart';
import '../registration/customers/domain/services/get/customer_get_service_impl.dart';
import '../registration/customers/domain/services/get/i_customer_get_service.dart';
import '../registration/customers/infra/repositories/customer_data_base_repository_impl.dart';
import '../registration/items/domain/repositories/i_item_repository.dart';
import '../registration/items/domain/services/get/i_items_get_service.dart';
import '../registration/services/domain/services/get_all/i_services_get_all_service.dart';
import 'presenter/controllers/budget_dialog_controller.dart';

class BudgetModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton<CustomersLocalDao>(CustomersLocalDao.new);
    i.addLazySingleton<ServicesLocalDao>(ServicesLocalDao.new);
    i.addLazySingleton<ItemsLocalDao>(ItemsLocalDao.new);
    i.addLazySingleton<CarsLocalDAO>(CarsLocalDAO.new);
    i.addLazySingleton<ICostumerRepository>(CostumerDataBaseRepositoryImpl.new);
    i.addLazySingleton<IServicesRepository>(ServicesDataBaseRepositoryImpl.new);
    i.addLazySingleton<IItemRepository>(ItemDataBaseRepositoryImpl.new);
    i.addLazySingleton<ICarRepository>(CarRemoveServiceImpl.new);
    i.addLazySingleton<ICustomerGetService>(CustomerGetServiceImpl.new);
    i.addLazySingleton<IServicesGetallService>(ServicesGetAllImpl.new);
    i.addLazySingleton<IItemsGetService>(ItemsGetServiceImpl.new);
    i.addLazySingleton<ICarsGetByCustomerService>(ItemsGetServiceImpl.new);

    i.addLazySingleton(
      () => BudgetDialogController(
        getCustomersService: i.get<ICustomerGetService>(),
        getServicesGetallService: i.get<IServicesGetallService>(),
        getItemsGetService: i.get<IItemsGetService>(),
      ),
    );
    i.addLazySingleton(() => BudgetsController());
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (_) => BudgetsPage(
              controller: Modular.get<BudgetsController>(),
              dialogController: Modular.get<BudgetDialogController>(),
            ));
    super.routes(r);
  }
}
