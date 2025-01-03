import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/services/get/car_get_service_impl.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/services/get/i_car_get_service.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/services/remove/car_remove_service_impl.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/services/remove/i_car_remove_service.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/services/save/car_save_service_impl.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/services/save/i_car_save_service.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/services/update/car_update_impl.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/services/update/i_car_update_service.dart';
import 'package:mechanic_app/app/modules/registration/cars/external/data_sources/car_local_dao.dart';
import 'package:mechanic_app/app/modules/registration/cars/infra/repositories/car_repository_impl.dart';
import 'package:mechanic_app/app/modules/registration/cars/presenter/controllers/car_registration_controller.dart';
import 'package:mechanic_app/app/modules/registration/cars/presenter/pages/car_registration_page.dart';

import 'domain/repositories/i_car_repository.dart';

class CarsModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton<CarsLocalDAO>(CarsLocalDAO.new);
    i.addLazySingleton<ICarRepository>(CarRepositoryImpl.new);
    i.addLazySingleton<ICarGetService>(CarGetServiceImpl.new);
    i.addLazySingleton<ICarSaveService>(CarSaveServiceImpl.new);
    i.addLazySingleton<ICarRemoveService>(CarRemoveServiceImpl.new);
    i.addLazySingleton<ICarUpdateService>(CarUpdateServiceImpl.new);
    i.add(CarRegistrationController.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const CarRegistrationPage());
    super.routes(r);
  }
}
