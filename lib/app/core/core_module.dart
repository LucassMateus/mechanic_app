import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/controllers/custom_drawer_controller.dart';
import 'package:mechanic_app/app/core/database/app_db_context.dart';
import 'package:mechanic_app/app/core/local_storage/i_local_storage.dart';
import 'package:mechanic_app/app/core/local_storage/shared_preferences_impl.dart';
import 'package:mechanic_app/app/modules/registration/cars/infra/repositories/car_repository_impl.dart';
// import 'package:mechanic_app/app/core/restClient/shared/rest_client.dart';
import 'package:sqflite_entity_mapper_orm/sqflite_entity_mapper_orm.dart';

import '../modules/registration/cars/domain/repositories/i_car_repository.dart';
import '../modules/registration/cars/domain/services/get/car_get_service_impl.dart';
import '../modules/registration/cars/domain/services/get/i_car_get_service.dart';
import '../modules/registration/cars/external/data_sources/car_local_dao.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<SqliteDbConnection>(() => SqliteDbConnection.get());
    i.addLazySingleton<DbEntityService>(() => DbEntityService.i);
    i.addLazySingleton<AppDbContext>(AppDbContext.new);
    // i.addSingleton(SqliteAdmConnection.new);
    // i.addLazySingleton<RestClient>(RestClient.new);
    i.addLazySingleton<ILocalStorage>(SharedPreferencesImpl.new);
    i.addLazySingleton<CustomDrawerController>(CustomDrawerController.new);
    i.addLazySingleton<CarsLocalDAO>(CarsLocalDAO.new);
    i.addLazySingleton<ICarRepository>(CarRepositoryImpl.new);
    i.addLazySingleton<ICarGetService>(CarGetServiceImpl.new);
    super.exportedBinds(i);
  }
}
