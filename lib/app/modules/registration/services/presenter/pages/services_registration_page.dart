import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/core/ui/components/custom_drawer.dart';
import 'package:mechanic_app/app/core/ui/components/custom_search_widget.dart';
import 'package:mechanic_app/app/core/ui/components/custom_text_field.dart';
import 'package:mechanic_app/app/core/ui/components/full_dialog_widget.dart';
import 'package:mechanic_app/app/core/ui/components/registration_card_widget.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/models/service_model.dart';
import 'package:mechanic_app/app/modules/registration/services/presenter/controllers/services_registration_controller.dart';

class ServicesRegistrationPage extends StatefulWidget {
  ServicesRegistrationPage({super.key});

  final controller = ServicesRegistrationController();

  @override
  State<ServicesRegistrationPage> createState() =>
      _ServicesRegistrationPageState();
}

class _ServicesRegistrationPageState extends State<ServicesRegistrationPage> {

  ServicesRegistrationController get controller => widget.controller;

  @override
  void initState() {
    controller.generateServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Serviços'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => FullDialogWidget(
                  title: 'Novo Serviço',
                  onConfirmText: 'Salvar',
                  onCancelText: 'Cancelar',
                  onConfirmPressed: () {},
                  onCancelPressed: () {},
                  builder: (context) {
                    return const Column(
                      children: [
                        CustomTextFormField(label: 'Nome'),
                        CustomTextFormField(label: 'Descrição'),
                        CustomTextFormField(label: 'Total de horas'),
                        CustomTextFormField(label: 'Items'),
                        CustomTextFormField(label: 'Preço por carro'),
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
              // onChanged: controller.filterItems,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: controller,
                builder: (_, state, child) {
                  return switch (state) {
                    SuccessState(:final List<ServiceModel> data) =>
                      ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final service = data[index];
                          return RegistrationCardWidget(
                            title: service.name,
                            subTitle: service.description,
                            color: colorScheme.outlineVariant,
                            // onRemove: controller.remove(item),
                            onEdit: () {
                              showDialog(
                                context: context,
                                builder: (context) => FullDialogWidget(
                                  title: 'Serviço: ${service.name}',
                                  onConfirmText: 'Atualizar',
                                  onCancelText: 'Cancelar',
                                  onConfirmPressed: () {},
                                  onCancelPressed: () =>
                                      Navigator.of(context).pop(service),
                                  builder: (context) {
                                    return const Column(
                                      children: [
                                        CustomTextFormField(label: 'Nome'),
                                        CustomTextFormField(label: 'Descrição'),
                                        CustomTextFormField(
                                            label: 'Total de horas'),
                                        CustomTextFormField(label: 'Items'),
                                        CustomTextFormField(
                                            label: 'Preço por carro'),
                                      ],
                                    );
                                  },
                                ),
                              );
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
