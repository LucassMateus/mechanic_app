import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/services/get/customer_get_service_impl.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/services/get/i_customer_get_service.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/services/remove/i_customer_remove_service.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/services/save/i_customer_save_service.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/services/update/i_customer_update_service.dart';
import 'package:mechanic_app/app/modules/registration/customers/infra/repositories/customer_data_base_repository_impl.dart';
import 'package:mechanic_app/app/modules/registration/customers/infra/repositories/i_customer_repository.dart';
import 'package:mechanic_app/app/modules/registration/customers/presenter/controllers/costumer_registration_controller.dart';
import 'package:mechanic_app/app/modules/registration/customers/presenter/pages/costumer_registration_page.dart';

import 'domain/services/remove/customer_remove_service_impl.dart';
import 'domain/services/save/customer_save_service_impl.dart';
import 'domain/services/update/customer_update_service_impl.dart';

class CustomersModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addSingleton<ICostumerRepository>(CostumerDataBaseRepositoryImpl.new);
    i.addSingleton<ICustomerGetService>(CustomerGetServiceImpl.new);
    i.addSingleton<ICustomerSaveService>(CustomerSaveServiceImpl.new);
    i.addSingleton<ICustomerRemoveService>(CustomerRemoveServiceImpl.new);
    i.addSingleton<ICustomerUpdateService>(CustomerUpdateServiceImpl.new);
    i.add(CostumerRegistrationController.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (_) => CostumerRegistrationPage(
            controller: Modular.get<CostumerRegistrationController>()));
    super.routes(r);
  }
}
