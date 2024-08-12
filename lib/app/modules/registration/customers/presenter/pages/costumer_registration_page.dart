import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mechanic_app/app/core/ui/alerts/alerts.dart';

import 'package:mechanic_app/app/modules/registration/customers/domain/models/customer_model.dart';
import 'package:mechanic_app/app/modules/registration/customers/presenter/controllers/costumer_registration_controller.dart';

import '../../../../../core/state/base_state.dart';
import '../../../../../core/ui/components/custom_drawer.dart';
import '../../../../../core/ui/components/custom_search_widget.dart';
import '../../../../../core/ui/components/custom_text_field.dart';
import '../../../../../core/ui/components/full_dialog_widget.dart';
import '../../../../../core/ui/components/registration_card_widget.dart';

class CostumerRegistrationPage extends StatefulWidget {
  const CostumerRegistrationPage({super.key, required this.controller});

  final CostumerRegistrationController controller;

  @override
  State<CostumerRegistrationPage> createState() =>
      _CostumerRegistrationPageState();
}

class _CostumerRegistrationPageState extends State<CostumerRegistrationPage> {
  CostumerRegistrationController get controller => widget.controller;

  @override
  void initState() {
    controller.addListener(listener);
    controller.getCustomers();
    super.initState();
  }

  void listener() {
    return switch (controller.state) {
      SuccessState() =>
        Alerts.showSuccess(context, 'Clientes buscados com sucesso'),
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
            onPressed: () {
              final nameEC = TextEditingController();
              final emailAddressEC = TextEditingController();
              final phoneEC = TextEditingController();
              showDialog(
                context: context,
                builder: (context) => FullDialogWidget(
                  title: 'Novo Cliente',
                  onConfirmText: 'Salvar',
                  onCancelText: 'Cancelar',
                  onConfirmPressed: () async {
                    await controller.saveCostumer(
                        nameEC.text, emailAddressEC.text, phoneEC.text);

                    if (!context.mounted) return;

                    Navigator.of(context).pop();
                  },
                  builder: (context) {
                    return Column(
                      children: [
                        CustomTextFormField(
                          label: 'Nome',
                          controller: nameEC,
                        ),
                        CustomTextFormField(
                          label: 'Telefone',
                          controller: phoneEC,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter()
                          ],
                        ),
                        CustomTextFormField(
                          label: 'Email',
                          controller: emailAddressEC,
                        ),
                        const CustomTextFormField(label: 'Carros'),
                      ],
                    );
                  },
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
                          final nameEC =
                              TextEditingController(text: customer.name);
                          final emailAddressEC =
                              TextEditingController(text: customer.email);
                          final phoneEC =
                              TextEditingController(text: customer.phoneNumber);

                          return RegistrationCardWidget(
                            title: customer.name,
                            subTitle: customer.phoneNumber,
                            color: colorScheme.outlineVariant,
                            onRemove: () => controller.removeCostumer(customer),
                            onEdit: () => showDialog(
                              context: context,
                              builder: (context) => FullDialogWidget(
                                title: 'Cliente: ${customer.name}',
                                onConfirmText: 'Atualizar',
                                onCancelText: 'Cancelar',
                                onConfirmPressed: () async =>
                                    await controller.updateCostumer(
                                        customer.id,
                                        nameEC.text,
                                        emailAddressEC.text,
                                        phoneEC.text),
                                builder: (context) {
                                  return Column(
                                    children: [
                                      CustomTextFormField(
                                        label: 'Nome',
                                        controller: nameEC,
                                      ),
                                      CustomTextFormField(
                                        label: 'Telefone',
                                        controller: phoneEC,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          TelefoneInputFormatter()
                                        ],
                                      ),
                                      CustomTextFormField(
                                        label: 'Email',
                                        controller: emailAddressEC,
                                      ),
                                      const CustomTextFormField(
                                          label: 'Carros'),
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
