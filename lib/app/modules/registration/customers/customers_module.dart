import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/models/customer_model.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/services/get/customer_get_service_impl.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/services/get/i_customer_get_service.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/services/remove/i_customer_remove_service.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/services/save/i_customer_save_service.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/services/update/i_customer_update_service.dart';
import 'package:mechanic_app/app/modules/registration/customers/external/data_sources/customers_local_dao.dart';
import 'package:mechanic_app/app/modules/registration/customers/infra/repositories/customer_data_base_repository_impl.dart';
import 'package:mechanic_app/app/modules/registration/customers/presenter/controllers/costumer_list_controller.dart';
import 'package:mechanic_app/app/modules/registration/customers/presenter/controllers/customer_up_save_controller.dart';
import 'package:mechanic_app/app/modules/registration/customers/presenter/pages/costumer_list_page.dart';
import 'package:mechanic_app/app/modules/registration/customers/presenter/pages/customer_up_save_page.dart';

import 'domain/repositories/i_customer_repository.dart';
import 'domain/services/remove/customer_remove_service_impl.dart';
import 'domain/services/save/customer_save_service_impl.dart';
import 'domain/services/update/customer_update_service_impl.dart';

class CustomersModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton(CustomersLocalDao.new);
    i.addLazySingleton<ICostumerRepository>(CostumerDataBaseRepositoryImpl.new);
    i.addLazySingleton<ICustomerGetService>(CustomerGetServiceImpl.new);
    i.addLazySingleton<ICustomerSaveService>(CustomerSaveServiceImpl.new);
    i.addLazySingleton<ICustomerRemoveService>(CustomerRemoveServiceImpl.new);
    i.addLazySingleton<ICustomerUpdateService>(CustomerUpdateServiceImpl.new);
    i.add(CostumerListController.new);
    i.add(CustomerUpSaveController.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => const CostumerListPage(),
    );
    r.child(
      '/save',
      child: (_) {
        return const CustomerUpSavePage(
          isUpdate: false,
        );
      },
    );
    r.child(
      '/edit',
      child: (_) {
        final customer = r.args.data as CustomerModel;
        return CustomerUpSavePage(
          isUpdate: true,
          customer: customer,
        );
      },
    );
    super.routes(r);
  }
}
