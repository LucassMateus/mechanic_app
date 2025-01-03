import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/ui/alerts/alerts.dart';
import 'package:mechanic_app/app/core/ui/base_state_page.dart/base_state_page.dart';
import 'package:mechanic_app/app/core/ui/components/confirm_dialog.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/models/customer_model.dart';
import 'package:mechanic_app/app/modules/registration/customers/presenter/controllers/costumer_list_controller.dart';

import '../../../../../core/state/base_state.dart';
import '../../../../../core/ui/components/custom_drawer.dart';
import '../../../../../core/ui/components/custom_search_widget.dart';
import '../../../../../core/ui/components/registration_card_widget.dart';
import '../../domain/dtos/customer_save_dto.dart';

class CostumerListPage extends StatefulWidget {
  const CostumerListPage({super.key});

  @override
  State<CostumerListPage> createState() => _CostumerListPageState();
}

class _CostumerListPageState
    extends BaseStatePage<CostumerListPage, CostumerListController> {
  final customerSaveDto = CustomerSaveDto(
    name: 'Teste',
    phoneNumber: '51996212825',
    email: 'testetransação@gmail.com',
  );

  @override
  void onReady() {
    controller.init();
  }

  @override
  void listener() {
    return switch (controller.state) {
      SuccessState(:final message) => {
          if (message != null) Alerts.showSuccess(context, message),
        },
      ErrorState(:final exception) =>
        Alerts.showFailure(context, exception.toString()),
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Modular.to
                  .pushNamed<CustomerModel>('/registration/costumers/save');
              if (result != null) {
                controller.addCostumer(result);
              }
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
              onChanged: controller.filterCostumer,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: controller,
                builder: (_, state, child) {
                  return switch (state) {
                    SuccessState(:final List<CustomerModel> data) =>
                      ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final customer = data[index];

                          return RegistrationCardWidget(
                            title: customer.name,
                            subTitle: customer.phoneNumber,
                            color: colorScheme.outlineVariant,
                            onRemove: () => ConfirmDialog.show(
                              context: context,
                              title: 'Alerta',
                              message:
                                  'Deseja realmente excluir o cliente ${customer.id} - ${customer.name}?',
                              onConfirm: () async {
                                await controller.removeCostumer(customer);
                              },
                            ),
                            onEdit: () async {
                              final result =
                                  await Modular.to.pushNamed<CustomerModel>(
                                '/registration/costumers/edit',
                                arguments: customer,
                              );

                              if (result != null) {
                                controller.updateCostumer(result);
                              }
                            },
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
