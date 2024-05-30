import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/core/ui/components/custom_drawer.dart';
import 'package:mechanic_app/app/core/ui/components/custom_search_widget.dart';
import 'package:mechanic_app/app/core/ui/components/registration_card_widget.dart';
import 'package:mechanic_app/app/core/ui/pages/new_budget_page.dart';
import 'package:mechanic_app/app/modules/budget/domain/models/budget_model.dart';
import 'package:mechanic_app/app/modules/budget/presenter/controllers/budgets_controller.dart';

import '../../../../core/models/document_service.dart';

class BudgetsPage extends StatefulWidget {
  BudgetsPage({super.key});

  final BudgetsController controller = BudgetsController();
  @override
  State<BudgetsPage> createState() => _BudgetsPageState();
}

class _BudgetsPageState extends State<BudgetsPage> {
  BudgetsController get controller => widget.controller;

  @override
  void initState() {
    controller.generateBudgets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orçamentos'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const BudgetDialog(
                  title: 'Novo Orçamento',
                  onConfirmText: 'Salvar',
                  onCancelText: 'Cancelar',
                ),
              );
            },
            icon: const Icon(
              Icons.add_outlined,
              size: 28,
            ),
          )
        ],
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            CustomSearchWidget(
              label: 'Digite para pesquisar...',
              color: colorScheme.outlineVariant,
              onChanged: controller.filterBySearchText,
              actions: [
                PopupMenuItem<String>(
                  value: DocumentStatus.approved.name,
                  child: Row(
                    children: [
                      DocumentStatus.approved.icon,
                      const SizedBox(width: 8),
                      Text(DocumentStatus.approved.name),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: DocumentStatus.scheduled.name,
                  child: Row(
                    children: [
                      DocumentStatus.scheduled.icon,
                      const SizedBox(width: 8),
                      Text(DocumentStatus.scheduled.name),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: DocumentStatus.pending.name,
                  child: Row(
                    children: [
                      DocumentStatus.pending.icon,
                      const SizedBox(width: 8),
                      Text(DocumentStatus.pending.name),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Todos',
                  child: Row(
                    children: [
                      Icon(Icons.format_align_justify_outlined),
                      SizedBox(width: 8),
                      Text('Todos'),
                    ],
                  ),
                ),
              ],
              onSelectedAction: (value) => controller.filterByStatus(value),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: controller,
                builder: (_, state, child) {
                  return switch (state) {
                    SuccessState(:final List<BudgetModel> data) =>
                      ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final budget = data[index];
                          return RegistrationCardWidget(
                            title: budget.id.toString(),
                            subTitle: budget.car.model,
                            color: budget.status.color,
                            leading: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                children: [
                                  budget.status.icon,
                                  Text(budget.status.name),
                                ],
                              ),
                            ),
                            onRemove: () => controller.removeBudget(budget),
                            onEdit: () => showDialog(
                              context: context,
                              builder: (context) {
                                return BudgetDialog(
                                  title: 'Orçamento: ${budget.id}',
                                  onConfirmText: 'Atualizar',
                                  onCancelText: 'Cancelar',
                                  showStatus: true,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    _ => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
