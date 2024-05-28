
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/modules/registration/items/presenter/pages/items_registration_page.dart';

class ItemsModule extends Module {
    @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => ItemsRegistrationPage());
    super.routes(r);
  }
}