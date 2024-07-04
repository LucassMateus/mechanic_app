import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/helpers/functions.dart';
import 'package:mechanic_app/app/modules/budget/domain/models/budget_model.dart';

class BudgetsController extends BaseController {
  BudgetsController() : super(InitialState());

  final List<BudgetModel> _allBudgets = [];
  List<BudgetModel> _filteredBudgets = [];

  String _searchText = '';
  String? _statusFilter;

  void filterBySearchText(String value) {
    _searchText = value;
    _applyFilters();
  }

  void filterByStatus(String? status) {
    _statusFilter = status;
    _applyFilters();
  }

  void _applyFilters() {
    List<BudgetModel> filtered = _allBudgets;

    if (_searchText.isNotEmpty) {
      filtered = filtered
          .where((budget) => budget.clientName
              .toLowerCase()
              .contains(_searchText.toLowerCase()))
          .toList();
    }

    if (_statusFilter != null && _statusFilter != 'Todos') {
      filtered = filtered
          .where((budget) => budget.status.name == _statusFilter)
          .toList();
    }

    _filteredBudgets = filtered;
    update(SuccessState(data: _filteredBudgets));
  }

  void generateBudgets() {
    final budgets = generateBudgetsList(10);
    _allBudgets.addAll(budgets);
    _applyFilters();
  }

  void removeBudget(BudgetModel budget) {
    _allBudgets.remove(budget);
    _filteredBudgets.remove(budget);
    update(SuccessState(data: _filteredBudgets));
  }
}
