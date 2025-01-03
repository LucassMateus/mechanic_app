import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/services/get/i_items_get_service.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/services/get/items_get_service_impl.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/services/remove/i_items_remove_service.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/services/remove/items_remove_service_impl.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/services/save/i_items_save_service.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/services/save/items_save_service_impl.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/services/update/i_items_update_service.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/services/update/i_items_update_service_impl.dart';
import 'package:mechanic_app/app/modules/registration/items/infra/repositories/item_data_base_repository_impl.dart';
import 'package:mechanic_app/app/modules/registration/items/presenter/controllers/items_registration_controller.dart';
import 'package:mechanic_app/app/modules/registration/items/presenter/pages/items_registration_page.dart';

import 'domain/repositories/i_item_repository.dart';
import 'external/data_sources/items_local_dao.dart';

class ItemsModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton<ItemsLocalDao>(ItemsLocalDao.new);
    i.addLazySingleton<IItemRepository>(ItemDataBaseRepositoryImpl.new);
    i.addLazySingleton<IItemsGetService>(ItemsGetServiceImpl.new);
    i.addLazySingleton<IItemsSaveService>(ItemsSaveServiceImpl.new);
    i.addLazySingleton<IItemsRemoveService>(ItemsRemoveServiceImpl.new);
    i.addLazySingleton<IItemsUpdateService>(ItemsUpdateServiceImpl.new);
    i.add(ItemsRegistrationController.new);
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (_) => ItemsRegistrationPage(
            controller: Modular.get<ItemsRegistrationController>()));
    super.routes(r);
  }
}
