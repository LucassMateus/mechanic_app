import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/auth/auth_module.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/core/pages/splash_page.dart';
import 'package:mechanic_app/app/modules/home/home_module.dart';
import 'package:mechanic_app/app/modules/registration/items/items_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const SplashPage());
    r.module('/auth', module: AuthModule());
    r.module('/home', module: HomeModule());
    r.module('/items', module: ItemsModule());
    super.routes(r);
  }
}
