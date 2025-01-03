import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/modules/registration/cars/cars_module.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:mechanic_app/app/modules/registration/items/items_module.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/dtos/service_car_details_dto.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/models/service_model.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/delete/i_services_delete_service.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/delete/services_delete_service_impl.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/filter/i_services_filter_service.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/filter/services_filter_service_impl.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/get_all/i_services_get_all_service.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/get_all/services_get_all_impl.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/save/i_services_save_service.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/save/services_save_impl.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/update/i_services_update_service.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/update/services_update_impl.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/repositories/i_services_repository.dart';
import 'package:mechanic_app/app/modules/registration/services/external/data_sources/services_local_dao.dart';
import 'package:mechanic_app/app/modules/registration/services/infra/repositories/services_data_base_repository_impl.dart';
import 'package:mechanic_app/app/modules/registration/services/presenter/controllers/service_price_per_item_controller.dart';
import 'package:mechanic_app/app/modules/registration/services/presenter/controllers/services_list_controller.dart';
import 'package:mechanic_app/app/modules/registration/services/presenter/controllers/services_price_per_car_controller.dart';
import 'package:mechanic_app/app/modules/registration/services/presenter/controllers/services_up_save_controller.dart';
import 'package:mechanic_app/app/modules/registration/services/presenter/pages/services_list_page.dart';
import 'package:mechanic_app/app/modules/registration/services/presenter/pages/services_price_per_item_page.dart';
import 'package:mechanic_app/app/modules/registration/services/presenter/pages/services_up_save_page.dart';

import 'presenter/pages/services_price_per_car_page.dart';

class ServicesModule extends Module {
  @override
  List<Module> get imports => [CoreModule(), ItemsModule(), CarsModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton(ServicesLocalDao.new);
    i.addLazySingleton<IServicesRepository>(ServicesDataBaseRepositoryImpl.new);
    i.addLazySingleton<IServicesGetallService>(ServicesGetAllImpl.new);
    i.addLazySingleton<IServicesSaveService>(ServicesSaveServiceImpl.new);
    i.addLazySingleton<IServicesUpdateService>(ServicesUpdateServiceImpl.new);
    i.addLazySingleton<IServicesDeleteService>(ServicesDeleteServiceImpl.new);
    i.addLazySingleton<IServicesFilterService>(ServicesFilterServiceImpl.new);
    i.addLazySingleton(ServicesListController.new);
    i.addLazySingleton(ServicesUpSaveController.new);
    i.addLazySingleton(ServicesPricePerCarController.new);
    i.addLazySingleton(ServicePricePerItemController.new);
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => const ServicesListPage(),
    );
    r.child(
      '/save',
      child: (_) {
        return const ServicesUpSavePage(
          isUpdate: false,
        );
      },
    );
    r.child(
      '/edit',
      child: (_) {
        final service = r.args.data as ServiceModel;
        return ServicesUpSavePage(
          isUpdate: true,
          service: service,
        );
      },
    );
    r.child('/prices-per-car', child: (_) {
      final carDetails = Set<ServiceCarDetailsDto>.from(r.args.data as Set);
      return ServicesPricePerCarPage(carsDetails: carDetails);
    });
    r.child('/items', child: (_) {
      final items = Set<ItemModel>.from(r.args.data as Set);
      return ServicesPricePerItemPage(items: items);
    });

    super.routes(r);
  }
}
