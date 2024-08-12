import 'dart:math';

import 'package:mechanic_app/app/core/models/document_service.dart';
import 'package:mechanic_app/app/modules/budget/domain/models/budget_model.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/models/service_model.dart';
import 'package:mechanic_app/app/modules/service_order/domain/models/service_order.dart';

import '../modules/registration/customers/domain/models/customer_model.dart';

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
        status: DocumentStatus.approved,
        // status: DocumentStatus.values[i % DocumentStatus.values.length],
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
    id: Random().nextInt(100),
    model: randomModel,
    brand: randomBrand,
    year: year,
  );
}

List<ItemModel> generateItems() {
  final newItems = [
    ItemModel(code: 1, description: 'Item 1', cost: 10.0),
    ItemModel(code: 2, description: 'Item 2', cost: 20.0),
    ItemModel(code: 3, description: 'Item 3', cost: 20.0),
    ItemModel(code: 12, description: 'Item 12', cost: 20.0),
    ItemModel(code: 23, description: 'Item 23', cost: 20.0),
    ItemModel(code: 1, description: 'Item 1', cost: 10.0),
    ItemModel(code: 2, description: 'Item 2', cost: 20.0),
    ItemModel(code: 3, description: 'Item 3', cost: 20.0),
    ItemModel(code: 12, description: 'Item 12', cost: 20.0),
    ItemModel(code: 23, description: 'Item 23', cost: 20.0),
  ];

  return newItems;
}

List<BudgetModel> generateBudgetsList(int count) {
  final List<BudgetModel> budgets = [];
  final Random random = Random();

  for (int i = 0; i < count; i++) {
    budgets.add(
      BudgetModel(
        id: i,
        clientName: 'Client $i',
        car: CarModel(
          id: i,

          model: 'Model $i',
          brand: 'Brand $i',
          year: 2000 + random.nextInt(23), // Year between 2000 and 2023
        ),
        date: DateTime.now().subtract(Duration(days: random.nextInt(365))),
        services: List<ServiceModel>.generate(
          3,
          (index) => ServiceModel(
            id: index,
            name: 'Service $index',
            description: 'Description of Service $index',
            hoursAmount: random.nextInt(10),
            items: List<ItemModel>.generate(
              2,
              (index) => ItemModel(
                code: index,
                description: 'Item $index',
                cost: random.nextDouble() * 50,
              ),
            ),
            pricePerCar: {
              CarModel(
                  id: i,
                  model: 'Model $i',
                  brand: 'Brand $i',
                  year: 2000 + random.nextInt(23)): random.nextDouble() * 100,
            },
          ),
        ),
        additionalItems: List<ItemModel>.generate(
          2,
          (index) => ItemModel(
            code: index,
            description: 'Additional Item $index',
            cost: random.nextDouble() * 50,
          ),
        ),
        additionalHours: random.nextDouble().toInt() * 10,
        observations: 'Observation $i',
        // status: DocumentStatus.approved,
        status: DocumentStatus.values[i % DocumentStatus.values.length],
      ),
    );
  }
  return budgets;
}

List<ServiceModel> createServiceModels({required int count}) {
  return List.generate(count, (index) {
    return ServiceModel(
      id: index,
      name: 'Serviço $index',
      description: 'Descrição do serviço $index...',
      hoursAmount: 2 + index, // Ajuste conforme necessário
      items: [
        ItemModel(
          code: index,
          description: 'Peça de Reposição $index',
          cost: 50.0 + index * 10, // Ajuste conforme necessário
        ),
      ],
      pricePerCar: {
        CarModel(
          id: index,
          model: 'Modelo $index',
          brand: 'Marca $index',
          year: 2021 + index,
        ): 200.0 + index * 20, // Ajuste conforme necessário
      },
    );
  });
}

List<CustomerModel> generateCustomers(int count) {
  final random = Random();
  final List<CustomerModel> customers = [];

  final names = [
    'John Doe',
    'Jane Smith',
    'Alice Johnson',
    'Bob Brown',
    'Charlie Davis'
  ];
  final emailProviders = ['example.com', 'mail.com', 'test.com'];
  final phonePrefixes = ['123', '456', '789'];

  for (int i = 0; i < count; i++) {
    final name = names[random.nextInt(names.length)];
    final phoneNumber =
        '${phonePrefixes[random.nextInt(phonePrefixes.length)]}-${random.nextInt(10000000) + 10000000}';
    final email = random.nextBool()
        ? '$name@${emailProviders[random.nextInt(emailProviders.length)]}'
            .replaceAll(' ', '')
            .toLowerCase()
        : null;

    final cars = generateCars(random.nextInt(3) +
        1); // Generates between 1 and 3 cars for each customer

    customers.add(CustomerModel(
      id: random.nextInt(100),
      name: name,
      phoneNumber: phoneNumber,
      email: email,
      cars: cars,
    ));
  }

  return customers;
}

List<CarModel> generateCars(int count) {
  final random = Random();
  final List<CarModel> cars = [];

  final models = ['Model S', 'Model 3', 'Model X', 'Model Y', 'Roadster'];
  final brands = ['Tesla', 'BMW', 'Audi', 'Mercedes', 'Toyota'];

  for (int i = 0; i < count; i++) {
    final model = models[random.nextInt(models.length)];
    final brand = brands[random.nextInt(brands.length)];
    final year =
        2000 + random.nextInt(24); // Generates a year between 2000 and 2023

    cars.add(CarModel(
      id: random.nextInt(100),
      model: model,
      brand: brand,
      year: year,
    ));
  }

  return cars;
}
