import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/modules/auth/auth_module.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/core/modules/register/register_module.dart';
import 'package:mechanic_app/app/core/pages/splash_page.dart';
import 'package:mechanic_app/app/modules/budget/budget_module.dart';
import 'package:mechanic_app/app/modules/home/home_module.dart';
import 'package:mechanic_app/app/modules/registration/registration_module.dart';
import 'package:mechanic_app/app/modules/service_order/service_orders_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const SplashPage());
    r.module('/auth', module: AuthModule());
    r.module('/register', module: RegisterModule());
    r.module('/home', module: HomeModule());
    r.module('/budgets', module: BudgetModule());
    r.module('/service-orders', module: ServiceOrdersModule());
    r.module('/registration', module: RegistrationModule());
    super.routes(r);
  }
}
