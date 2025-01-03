import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/core/ui/alerts/alerts.dart';
import 'package:mechanic_app/app/core/ui/base_state_page.dart/base_state_page.dart';
import 'package:mechanic_app/app/core/ui/components/custom_search_widget.dart';
import 'package:mechanic_app/app/core/ui/components/custom_text_field.dart';
import 'package:mechanic_app/app/core/ui/components/error_widget.dart';

import '../../../../../core/theme/theme_config.dart';
import '../../../../../core/ui/components/multi_select_dialog.dart';
import '../../../cars/domain/models/car_model.dart';
import '../../domain/dtos/service_car_details_dto.dart';
import '../controllers/services_price_per_car_controller.dart';

class ServicesPricePerCarPage extends StatefulWidget {
  final Set<ServiceCarDetailsDto> carsDetails;
  const ServicesPricePerCarPage({super.key, required this.carsDetails});

  @override
  State<ServicesPricePerCarPage> createState() =>
      _ServicesPricePerCarPageState();
}

class _ServicesPricePerCarPageState extends BaseStatePage<
    ServicesPricePerCarPage, ServicesPricePerCarController> {
  @override
  Future<void> onReady() async {
    await controller.init(widget.carsDetails);
  }

  @override
  void listener() {
    return switch (controller.state) {
      RemovedCarDetailsState(:final carDetails) => Alerts.showSuccess(
          context,
          '${carDetails.car.fullNameWithYear} excluído',
        ),
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preço por carro'),
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.pop(controller.carsDetails);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCarsDialog,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomSearchWidget(
              label: 'Pesquisar carro...',
              color: ThemeConfig.theme.colorScheme.surfaceContainer,
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder(
                valueListenable: controller,
                builder: (_, state, child) {
                  return switch (state) {
                    SuccessState() => Expanded(
                        child: ListView.builder(
                          itemCount: controller.carsDetails.length,
                          itemBuilder: (context, index) {
                            final carDetails =
                                controller.carsDetails.elementAt(index);
                            final hoursEC = TextEditingController(
                              text: carDetails.hoursPerCar.toString(),
                            );
                            final priceEC = TextEditingController(
                              text: carDetails.pricePerCar.toString(),
                            );

                            return Dismissible(
                              key: ValueKey(carDetails),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              onDismissed: (direction) =>
                                  controller.removeCarDetails(carDetails),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      // Ícone do carro
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          // color: Colors.blue.shade100,
                                          color: ThemeConfig.theme.colorScheme
                                              .primaryContainer,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Icon(
                                          Icons.directions_car,
                                          color: ThemeConfig
                                              .theme.colorScheme.primary,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      // Marca e modelo
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          '${carDetails.car.brand} ${carDetails.car.model}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            const Icon(
                                              Icons.access_time,
                                              size: 20,
                                              color: Colors.grey,
                                            ),
                                            CustomTextFormField(
                                              label: 'Horas',
                                              controller: hoursEC,
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                carDetails.setHoursPerCar(
                                                  double.tryParse(value ?? ''),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            const Icon(
                                              Icons.attach_money,
                                              size: 20,
                                              color: Colors.grey,
                                            ),
                                            CustomTextFormField(
                                              label: 'Valor',
                                              controller: priceEC,
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                carDetails.setPricePerCar(
                                                  double.tryParse(value ?? ''),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ErrorState(:final exception, :final message) =>
                      CustomErrorWidget(message, exception),
                    _ => const Center(child: CircularProgressIndicator()),
                  };
                })
          ],
        ),
      ),
    );
  }

  void _showCarsDialog() async {
    final Set<CarModel> items = controller.cars;

    final Iterable<CarModel>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog<CarModel>(
          title: 'Selecione os carros',
          items: items,
          selectedItems: controller.carsDetails.map((e) => e.car).toList(),
          itemTextBuilder: (item) {
            return '${item.brand} | ${item.model} | ${item.year}';
          },
          // onItemChange: (item, isSelected) {},
          onSearchChanged: controller.filterCars,
        );
      },
    );

    if (results != null) {
      setState(() {
        for (var car in results) {
          final addedCars = controller.carsDetails.map((e) => e.car).toSet();

          if (!addedCars.contains(car)) {
            final value = ServiceCarDetailsDto(car);
            controller.carsDetails.add(value);
          }
        }
      });
    }
  }
}
