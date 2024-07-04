
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/modules/budget/presenter/pages/budgets_page.dart';

class BudgetModule extends Module {
      @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => BudgetsPage());
    super.routes(r);
  }
}