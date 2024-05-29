import 'package:mechanic_app/app/core/controller/base_controller.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/helpers/functions.dart';

class BudgetsController extends BaseController {
  BudgetsController() : super(InitialState());

  void generateBudgets() {
    final budgets = generateBudgetsList(10);

    update(SuccessState(data: budgets));
  }
}
