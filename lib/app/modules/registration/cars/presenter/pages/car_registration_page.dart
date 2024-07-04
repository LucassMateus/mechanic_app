import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/ui/alerts/alerts.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import 'package:mechanic_app/app/modules/registration/cars/presenter/controllers/car_registration_controller.dart';

import '../../../../../core/state/base_state.dart';
import '../../../../../core/ui/components/custom_drawer.dart';
import '../../../../../core/ui/components/custom_search_widget.dart';
import '../../../../../core/ui/components/custom_text_field.dart';
import '../../../../../core/ui/components/full_dialog_widget.dart';
import '../../../../../core/ui/components/registration_card_widget.dart';

class CarRegistrationPage extends StatefulWidget {
  const CarRegistrationPage({super.key, required this.controller});

  final CarRegistrationController controller;

  @override
  State<CarRegistrationPage> createState() => _CarRegistrationPageState();
}

class _CarRegistrationPageState extends State<CarRegistrationPage> {
  CarRegistrationController get controller => widget.controller;

  @override
  void initState() {
    controller.addListener(listener);
    controller.getCars();
    super.initState();
  }

  void listener() {
    return switch (controller.state) {
      SuccessState() =>
        Alerts.showSuccess(context, 'Carros buscados com sucesso'),
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
        title: const Text('Carros'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    final modelEC = TextEditingController();
                    final brandEC = TextEditingController();
                    final yearEC = TextEditingController();
                    return FullDialogWidget(
                      title: 'Novo Carro',
                      onConfirmText: 'Salvar',
                      onCancelText: 'Cancelar',
                      onConfirmPressed: () async {
                        await controller.saveCar(
                          modelEC.text,
                          brandEC.text,
                          int.parse(yearEC.text),
                        );
                      },
                      onDispose: () {
                        modelEC.dispose();
                        brandEC.dispose();
                        yearEC.dispose();
                      },
                      builder: (context) {
                        return Column(
                          children: [
                            CustomTextFormField(
                                label: 'Modelo', controller: modelEC),
                            CustomTextFormField(
                                label: 'Marca', controller: brandEC),
                            CustomTextFormField(
                                label: 'Ano', controller: yearEC),
                          ],
                        );
                      },
                    );
                  });
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
              onChanged: controller.filterCar,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: controller,
                builder: (_, state, child) {
                  return switch (state) {
                    SuccessState(:final List<CarModel> data) =>
                      ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final car = data[index];
                          return RegistrationCardWidget(
                            title: car.brand,
                            subTitle: '${car.model} ${car.year.toString()}',
                            color: colorScheme.outlineVariant,
                            onRemove: () => controller.removeCar(car),
                            onEdit: () => showDialog(
                                context: context,
                                builder: (context) {
                                  final modelEC =
                                      TextEditingController(text: car.model);
                                  final brandEC =
                                      TextEditingController(text: car.brand);
                                  final yearEC = TextEditingController(
                                      text: car.year.toString());
                                  return FullDialogWidget(
                                    title:
                                        'Carro: ${car.model} ${car.year.toString()}',
                                    onConfirmText: 'Atualizar',
                                    onCancelText: 'Cancelar',
                                    onConfirmPressed: () {
                                      controller.updateCar(
                                        modelEC.text,
                                        brandEC.text,
                                        yearEC.text,
                                        car.id,
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    onDispose: () {
                                      modelEC.dispose();
                                      brandEC.dispose();
                                      yearEC.dispose();
                                    },
                                    builder: (context) {
                                      return Column(
                                        children: [
                                          CustomTextFormField(
                                              label: 'Modelo',
                                              controller: modelEC),
                                          CustomTextFormField(
                                              label: 'Marca',
                                              controller: brandEC),
                                          CustomTextFormField(
                                              label: 'Ano', controller: yearEC),
                                        ],
                                      );
                                    },
                                  );
                                }),
                          );
                        },
                      ),
                    ErrorState() => const SizedBox.shrink(),
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
