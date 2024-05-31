import 'package:flutter/material.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import 'package:mechanic_app/app/modules/registration/cars/presenter/controllers/car_registration_controller.dart';

import '../../../../../core/state/base_state.dart';
import '../../../../../core/ui/components/custom_drawer.dart';
import '../../../../../core/ui/components/custom_search_widget.dart';
import '../../../../../core/ui/components/custom_text_field.dart';
import '../../../../../core/ui/components/full_dialog_widget.dart';
import '../../../../../core/ui/components/registration_card_widget.dart';

class CarRegistrationPage extends StatefulWidget {
  CarRegistrationPage({super.key});

  final controller = CarRegistrationController();

  @override
  State<CarRegistrationPage> createState() => _CarRegistrationPageState();
}

class _CarRegistrationPageState extends State<CarRegistrationPage> {
  CarRegistrationController get controller => widget.controller;

  @override
  void initState() {
    controller.getCars();
    super.initState();
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
                builder: (context) => FullDialogWidget(
                  title: 'Novo Carro',
                  onConfirmText: 'Salvar',
                  onCancelText: 'Cancelar',
                  onConfirmPressed: () {},
                  builder: (context) {
                    return const Column(
                      children: [
                        CustomTextFormField(label: 'Modelo'),
                        CustomTextFormField(label: 'Marca'),
                        CustomTextFormField(label: 'Ano'),
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
                              builder: (context) => FullDialogWidget(
                                title:
                                    'Carro: ${car.model} ${car.year.toString()}',
                                onConfirmText: 'Atualizar',
                                onCancelText: 'Cancelar',
                                onConfirmPressed: () {},
                                builder: (context) {
                                  return const Column(
                                    children: [
                                      CustomTextFormField(label: 'Modelo'),
                                      CustomTextFormField(label: 'Marca'),
                                      CustomTextFormField(label: 'Ano'),
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
