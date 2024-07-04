import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/modules/registration/cars/cars_module.dart';
import 'package:mechanic_app/app/modules/registration/customers/customers_module.dart';
import 'package:mechanic_app/app/modules/registration/items/items_module.dart';
import 'package:mechanic_app/app/modules/registration/services/services_module.dart';

class RegistrationModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.module('/items', module: ItemsModule());
    r.module('/services', module: ServicesModule());
    r.module('/cars', module: CarsModule());
    r.module('/costumers', module: CustomersModule());
    super.routes(r);
  }
}
