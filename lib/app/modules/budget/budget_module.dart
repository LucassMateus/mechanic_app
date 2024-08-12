import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/modules/budget/presenter/controllers/budgets_controller.dart';
import 'package:mechanic_app/app/modules/budget/presenter/pages/budgets_page.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/services/get/items_get_service_impl.dart';
import 'package:mechanic_app/app/modules/registration/items/infra/repositories/i_item_repository.dart';
import 'package:mechanic_app/app/modules/registration/items/infra/repositories/item_data_base_repository_impl.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/get_all/services_get_all_impl.dart';
import 'package:mechanic_app/app/modules/registration/services/infra/repositories/i_services_repository.dart';
import 'package:mechanic_app/app/modules/registration/services/infra/repositories/services_data_base_repository_impl.dart';

import '../registration/customers/domain/services/get/customer_get_service_impl.dart';
import '../registration/customers/domain/services/get/i_customer_get_service.dart';
import '../registration/customers/infra/repositories/customer_data_base_repository_impl.dart';
import '../registration/customers/infra/repositories/i_customer_repository.dart';
import '../registration/items/domain/services/get/i_items_get_service.dart';
import '../registration/services/domain/services/get_all/i_services_get_all_service.dart';
import 'presenter/controllers/budget_dialog_controller.dart';

class BudgetModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.add<ICostumerRepository>(CostumerDataBaseRepositoryImpl.new);
    i.add<IServicesRepository>(ServicesDataBaseRepositoryImpl.new);
    i.add<IItemRepository>(ItemDataBaseRepositoryImpl.new);
    i.add<ICustomerGetService>(CustomerGetServiceImpl.new);
    i.add<IServicesGetallService>(ServicesGetAllImpl.new);
    i.add<IItemsGetService>(ItemsGetServiceImpl.new);
    i.addSingleton(
      () => BudgetDialogController(
        getCustomersService: i.get<ICustomerGetService>(),
        getServicesGetallService: i.get<IServicesGetallService>(),
        getItemsGetService: i.get<IItemsGetService>(),
      ),
    );
    i.addSingleton(() => BudgetsController());
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
