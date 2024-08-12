import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/delete/i_services_delete_service.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/delete/services_get_all_impl.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/get_all/i_services_get_all_service.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/get_all/services_get_all_impl.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/save/i_services_save_service.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/save/services_save_impl.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/update/i_services_update_service.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/update/services_update_impl.dart';
import 'package:mechanic_app/app/modules/registration/services/infra/repositories/i_services_repository.dart';
import 'package:mechanic_app/app/modules/registration/services/infra/repositories/services_data_base_repository_impl.dart';
import 'package:mechanic_app/app/modules/registration/services/presenter/controllers/services_registration_controller.dart';
import 'package:mechanic_app/app/modules/registration/services/presenter/pages/services_registration_page.dart';

class ServicesModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addSingleton<IServicesRepository>(ServicesDataBaseRepositoryImpl.new);
    i.addSingleton<IServicesGetallService>(ServicesGetAllImpl.new);
    i.addSingleton<IServicesSaveService>(ServicesSaveServiceImpl.new);
    i.addSingleton<IServicesUpdateService>(ServicesUpdateServiceImpl.new);
    i.addSingleton<IServicesDeleteService>(ServicesDeleteServiceImpl.new);
    i.addSingleton(ServicesRegistrationController.new);
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (_) => ServicesRegistrationPage(
              controller: Modular.get<ServicesRegistrationController>(),
            ));
    super.routes(r);
  }
}
