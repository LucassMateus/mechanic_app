import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/models/document_service.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/core/ui/components/custom_drawer.dart';
import 'package:mechanic_app/app/core/ui/components/custom_text_field.dart';
import 'package:mechanic_app/app/core/ui/components/full_dialog_widget.dart';
import 'package:mechanic_app/app/core/ui/components/registration_card_widget.dart';
import 'package:mechanic_app/app/modules/service_order/domain/models/service_order.dart';
import 'package:mechanic_app/app/modules/service_order/presenter/controllers/service_orders_controller.dart';

class ServiceOrdersPage extends StatefulWidget {
  ServiceOrdersPage({super.key});
  final ServiceOrdersController controller = ServiceOrdersController();

  @override
  State<ServiceOrdersPage> createState() => _ServiceOrdersPageState();
}

class _ServiceOrdersPageState extends State<ServiceOrdersPage> {
  ServiceOrdersController get controller => widget.controller;
  DocumentStatus selectedStatus = DocumentStatus.approved;

  @override
  void initState() {
    controller.getServiceOrders();
    controller.filterByStatus(selectedStatus.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final ThemeData theme = Theme.of(context);
    // final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordens de Serviço'),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            SegmentedButton<DocumentStatus>(
              segments: DocumentStatus.values
                  .map((status) => ButtonSegment<DocumentStatus>(
                        value: status,
                        label: Text(status.name),
                      ))
                  .toList(),
              selected: {selectedStatus},
              onSelectionChanged: (newSelection) {
                setState(() {
                  selectedStatus = newSelection.first;
                });
                controller.filterByStatus(selectedStatus.name);
              },
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: controller,
                builder: (_, state, child) {
                  return switch (state) {
                    SuccessState(:final List<ServiceOrderModel> data) =>
                      ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final serviceOrder = data[index];
                          return RegistrationCardWidget(
                            title: '123',
                            subTitle: serviceOrder.car.model,
                            color: serviceOrder.status.color,
                            leading: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                children: [
                                  serviceOrder.status.icon,
                                  Text(serviceOrder.status.name),
                                ],
                              ),
                            ),
                            // onRemove: () => controller.remove(item),
                            onEdit: () => showDialog(
                              context: context,
                              builder: (context) => FullDialogWidget(
                                title: 'Ordem: 123',
                                onConfirmText: 'Atualizar',
                                onCancelText: 'Cancelar',
                                onConfirmPressed: () {},
                                onCancelPressed: () =>
                                    Navigator.of(context).pop(),
                                builder: (context) {
                                  return const Column(
                                    children: [
                                      CustomTextFormField(label: 'Codigo'),
                                      CustomTextFormField(label: 'Descrição'),
                                      CustomTextFormField(label: 'Custo'),
                                    ],
                                  );
                                },
                              ),
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
