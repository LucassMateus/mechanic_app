import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/modules/service_order/presenter/pages/service_orders_page.dart';

class ServiceOrdersModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => ServiceOrdersPage());
    super.routes(r);
  }
}
