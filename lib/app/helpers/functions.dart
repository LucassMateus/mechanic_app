import 'dart:math';

import 'package:mechanic_app/app/core/models/car_model.dart';
import 'package:mechanic_app/app/modules/service_order/domain/models/service_order.dart';

List<ServiceOrderModel> generateServiceOrders(int quantity) {
  final List<ServiceOrderModel> serviceOrders = [];
  final car = generateRandomCar();

  for (int i = 1; i <= quantity; i++) {
    serviceOrders.add(
      ServiceOrderModel(
        startedDate: DateTime.now(),
        conclusionDate: DateTime.now().add(const Duration(days: 5)),
        additionalServices: [],
        clientName: 'Cliente $i',
        car: car,
        date: DateTime.now().subtract(Duration(days: i)),
        services: [],
        additionalItems: [],
        additionalHours: 0,
        observations: 'Observações da ordem de serviço $i',
        status: 'Em andamento',
      ),
    );
  }

  return serviceOrders;
}

CarModel generateRandomCar() {
  final List<String> models = [
    'Modelo 1',
    'Modelo 2',
    'Modelo 3',
    'Modelo 4',
    'Modelo 5'
  ];
  final List<String> brands = [
    'Marca 1',
    'Marca 2',
    'Marca 3',
    'Marca 4',
    'Marca 5'
  ];
  final int year = 2000 + Random().nextInt(23); // Ano entre 2000 e 2022

  final randomModel = models[Random().nextInt(models.length)];
  final randomBrand = brands[Random().nextInt(brands.length)];

  return CarModel(
    model: randomModel,
    brand: randomBrand,
    year: year,
  );
}
