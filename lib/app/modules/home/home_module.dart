import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/modules/home/domain/services/i_home_get_cars_service.dart';
import 'package:mechanic_app/app/modules/home/domain/services/i_home_get_cars_service_impl.dart';
import 'package:mechanic_app/app/modules/home/presenter/controllers/home_controller.dart';
import 'package:mechanic_app/app/modules/home/presenter/pages/home_page.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/services/get/customer_get_service_impl.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/services/get/i_customer_get_service.dart';
import 'package:mechanic_app/app/modules/registration/customers/infra/repositories/customer_data_base_repository_impl.dart';
import 'package:mechanic_app/app/modules/registration/customers/infra/repositories/i_customer_repository.dart';
import 'package:mechanic_app/app/modules/service_order/infra/repositories/i_service_order_repository.dart';
import 'package:mechanic_app/app/modules/service_order/infra/repositories/service_order_repository_impl.dart';

import '../budget/presenter/controllers/budget_dialog_controller.dart';
import '../registration/items/domain/services/get/i_items_get_service.dart';
import '../registration/items/domain/services/get/items_get_service_impl.dart';
import '../registration/items/infra/repositories/i_item_repository.dart';
import '../registration/items/infra/repositories/item_data_base_repository_impl.dart';
import '../registration/services/domain/services/get_all/i_services_get_all_service.dart';
import '../registration/services/domain/services/get_all/services_get_all_impl.dart';
import '../registration/services/infra/repositories/i_services_repository.dart';
import '../registration/services/infra/repositories/services_data_base_repository_impl.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.add<IServicesRepository>(ServicesDataBaseRepositoryImpl.new);
    i.add<IItemRepository>(ItemDataBaseRepositoryImpl.new);
    i.add<IServiceOrderRepository>(ServiceOrderRepositoryImpl.new);
    i.add<ICostumerRepository>(CostumerDataBaseRepositoryImpl.new);
    i.add<IServicesGetallService>(ServicesGetAllImpl.new);
    i.add<IItemsGetService>(ItemsGetServiceImpl.new);
    i.add<IHomeGetCarsService>(HomeGetCarsServiceImpl.new);
    i.add<ICustomerGetService>(CustomerGetServiceImpl.new);
    i.addSingleton(
      () => HomeController(
        service: i.get<IHomeGetCarsService>(),
      ),
    );
    i.addSingleton(
      () => BudgetDialogController(
        getCustomersService: i.get<ICustomerGetService>(),
        getServicesGetallService: i.get<IServicesGetallService>(),
        getItemsGetService: i.get<IItemsGetService>(),
      ),
    );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => HomePage(
        controller: Modular.get<HomeController>(),
        dialogController: Modular.get<BudgetDialogController>(),
      ),
    );
    super.routes(r);
  }
}
