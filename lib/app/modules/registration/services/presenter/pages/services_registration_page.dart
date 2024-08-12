import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/core/ui/alerts/alerts.dart';
import 'package:mechanic_app/app/core/ui/components/custom_drawer.dart';
import 'package:mechanic_app/app/core/ui/components/custom_search_widget.dart';
import 'package:mechanic_app/app/core/ui/components/custom_text_field.dart';
import 'package:mechanic_app/app/core/ui/components/full_dialog_widget.dart';
import 'package:mechanic_app/app/core/ui/components/registration_card_widget.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/models/service_model.dart';
import 'package:mechanic_app/app/modules/registration/services/presenter/controllers/services_registration_controller.dart';

class ServicesRegistrationPage extends StatefulWidget {
  const ServicesRegistrationPage({super.key, required this.controller});

  final ServicesRegistrationController controller;

  @override
  State<ServicesRegistrationPage> createState() =>
      _ServicesRegistrationPageState();
}

class _ServicesRegistrationPageState extends State<ServicesRegistrationPage> {
  ServicesRegistrationController get controller => widget.controller;

  @override
  void initState() {
    controller.addListener(listener);
    controller.getAllServices();
    super.initState();
  }

  void listener() {
    return switch (controller.state) {
      SuccessState() =>
        Alerts.showSuccess(context, 'Serviços carregados com sucesso.'),
      ErrorState() =>
        Alerts.showFailure(context, 'Erro ao carregar os serviços'),
      _ => null,
    };
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
              final nameEC = TextEditingController();
              final descriptionEC = TextEditingController();
              final hoursAmountEC = TextEditingController();
              showDialog(
                context: context,
                builder: (context) => FullDialogWidget(
                  title: 'Novo Serviço',
                  onConfirmText: 'Salvar',
                  onCancelText: 'Cancelar',
                  onConfirmPressed: () async => await controller.saveService(
                    nameEC.text,
                    descriptionEC.text,
                    int.parse(hoursAmountEC.text),
                    [],
                    {},
                  ),
                  onCancelPressed: () => Navigator.of(context).pop(),
                  builder: (context) {
                    return Column(
                      children: [
                        CustomTextFormField(
                          label: 'Nome',
                          controller: nameEC,
                        ),
                        CustomTextFormField(
                          label: 'Descrição',
                          controller: descriptionEC,
                        ),
                        CustomTextFormField(
                          label: 'Total de horas',
                          controller: hoursAmountEC,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            HoraInputFormatter(),
                          ],
                        ),
                        const CustomTextFormField(label: 'Items'),
                        CustomTextFormField(
                          label: 'Preço por carro',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CentavosInputFormatter(
                                casasDecimais: 2, moeda: true)
                          ],
                        ),
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
                            onRemove: () async =>
                                await controller.deleteService(service.id),
                            onEdit: () {
                              final nameEC =
                                  TextEditingController(text: service.name);
                              final descriptionEC = TextEditingController(
                                  text: service.description);
                              final hoursAmountEC = TextEditingController(
                                  text: service.hoursAmount.toString());
                              showDialog(
                                context: context,
                                builder: (context) => FullDialogWidget(
                                  title: 'Serviço: ${service.name}',
                                  onConfirmText: 'Atualizar',
                                  onCancelText: 'Cancelar',
                                  onConfirmPressed: () async {
                                    final updatedService = service.copyWith(
                                      name: nameEC.text,
                                      description: descriptionEC.text,
                                      hoursAmount:
                                          int.parse(hoursAmountEC.text),
                                    );
                                    if (updatedService != service) {
                                      await controller
                                          .updateService(updatedService);
                                    }
                                  },
                                  // onCancelPressed: () => Navigator.of(context).pop(service),
                                  builder: (context) {
                                    return Column(
                                      children: [
                                        CustomTextFormField(
                                          label: 'Nome',
                                          controller: nameEC,
                                        ),
                                        CustomTextFormField(
                                          label: 'Descrição',
                                          controller: descriptionEC,
                                        ),
                                        CustomTextFormField(
                                          label: 'Total de horas',
                                          controller: hoursAmountEC,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            HoraInputFormatter(),
                                          ],
                                        ),
                                        const CustomTextFormField(
                                            label: 'Items'),
                                        CustomTextFormField(
                                          label: 'Preço por carro',
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            CentavosInputFormatter(
                                                casasDecimais: 2, moeda: true)
                                          ],
                                        ),
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
