import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/modules/home/domain/services/i_home_get_cars_service.dart';
import 'package:mechanic_app/app/modules/home/domain/services/i_home_get_cars_service_impl.dart';
import 'package:mechanic_app/app/modules/home/presenter/controllers/home_controller.dart';
import 'package:mechanic_app/app/modules/home/presenter/pages/home_page.dart';
import 'package:mechanic_app/app/modules/service_order/home/infra/repositories/i_service_order_repository.dart';
import 'package:mechanic_app/app/modules/service_order/home/infra/repositories/service_order_repository_impl.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.add<IServiceOrderRepository>(ServiceOrderRepositoryImpl.new);
    i.add<IHomeGetCarsService>(HomeGetCarsServiceImpl.new);
    i.addSingleton(
      () => HomeController(service: i.get<IHomeGetCarsService>()),
    );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => HomePage(
        controller: Modular.get<HomeController>(),
      ),
    );
    super.routes(r);
  }
}
