import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/models/customers_cars.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/models/customer_model.dart';
import 'package:sqflite_entity_mapper_orm/sqflite_entity_mapper_orm.dart';

import '../../../../../core/database/app_db_context.dart';

class CustomersLocalDao extends SqliteGenericRepository<CustomerModel> {
  CustomersLocalDao({
    required this.dbContext,
    required this.dbConnection,
  }) : super(dbSet: dbContext.customers);

  @protected
  final SqliteDbConnection dbConnection;
  @protected
  final AppDbContext dbContext;

  Future<List<CustomerModel>> getAll() async {
    final customers = await super.dbSet.findAll();

    for (var customer in customers) {
      final query = dbContext.cars.query
          .select()
          .join('CustomersCars c', onClause: 'c.carId = x.id')
          .where('c.customerId = ${customer.id}');

      final results = await query.execute();
      final cars = results.entities;

      for (var item in cars) {
        customer.cars.add(item);
      }
    }

    return customers;
  }

  Future<CustomerModel> saveCustomer(CustomerModel entity) async {
    final transaction = dbConnection.getTransaction;
    try {
      await transaction.open();

      dbContext.customers.transaction(transaction).insert(entity);

      final nextCustomerId = await dbContext.customers.getNextInsertRowId();

      if (entity.cars.isNotEmpty) {
        for (var car in entity.cars) {
          final customerCar = CustomersCarsModel(
            id: -1,
            customerId: nextCustomerId,
            carId: car.id,
          );
          dbContext.customersCars.transaction(transaction).insert(customerCar);
          // await _carModelToCustomerCar (customerCar, transaction);
        }
      }

      await transaction.commit();

      final customer =
          await dbContext.customers.findFirstOrNull('id = ?', [nextCustomerId]);

      if (customer == null) {
        throw Exception('Ocorreu um erro ao salvar o cliente');
      }
      return customer;
    } finally {
      transaction.close();
    }
  }

  @override
  Future<void> update(CustomerModel entity) async {
    final transaction = dbConnection.getTransaction;
    try {
      await transaction.open();

      dbContext.customers.transaction(transaction).update(entity);

      final removedCars = await _findRemovedCars(entity);
      for (final car in removedCars) {
        dbContext.customersCars.transaction(transaction).delete(car);
      }

      final insertedCars = await _findInsertedCars(entity);
      for (final car in insertedCars) {
        dbContext.customersCars.transaction(transaction).insert(car);
      }

      // final customerCars =
      //     await _carModelToCustomerCar(entity.cars!, entity.id);
      // await dbContext.customersCars.mergeInTransaction(customerCars,
      //     transaction: transaction, shouldUpdate: (entity) async {
      //   return await dbContext.customersCars.exists(
      //     entity,
      //     closeConnetion: false,
      //     customClause: 'carId = ? AND customerId = ?',
      //     customArguments: [entity.carId, entity.customerId],
      //   );
      // }, shouldInsert: (entity) async {
      //   return !await dbContext.customersCars.exists(
      //     entity,
      //     closeConnetion: false,
      //     customClause: 'carId = ? AND customerId = ?',
      //     customArguments: [entity.carId, entity.customerId],
      //   );
      // }, removeWhenNotMatchAny: true);

      final results = await transaction.commit();

      debugPrint(results.toString());
    } finally {
      transaction.close();
    }
  }

  Future<List<CustomersCarsModel>> _findRemovedCars(
      CustomerModel entity) async {
    var query = dbContext.customersCars.query
        .select()
        .where('customerId = ${entity.id}');

    if (entity.cars.isNotEmpty) {
      query = query
          .and()
          .not()
          .inValues('carId', entity.cars.map((e) => e.id).toList());
    }

    final results = await query.execute();
    final carsToRemove = results.entities;

    return carsToRemove;
  }

  Future<List<CustomersCarsModel>> _findInsertedCars(
      CustomerModel entity) async {
    final updatedCarList = entity.cars;

    if (updatedCarList.isNotEmpty) {
      final carsToInserted = <CustomersCarsModel>[];

      final query = dbContext //
          .cars
          .query
          .select()
          .join('CustomersCarsModel c', onClause: 'c.carId = x.id')
          .where('c.customerId = ${entity.id}');

      final results = await query.execute();

      final customerCars = results.entities;

      for (var car in updatedCarList) {
        if (!customerCars.contains(car)) {
          final customerCar = CustomersCarsModel(
            id: -1,
            customerId: entity.id,
            carId: car.id,
          );

          carsToInserted.add(customerCar);
        }
      }
      return carsToInserted;
    }
    return List<CustomersCarsModel>.empty();
  }

  // Future<List<CustomersCarsModel>> _carModelToCustomerCar(
  //     List<CarModel> cars, int customerId) async {
  //   final customerCars = <CustomersCarsModel>[];
  //   for (var car in cars) {
  //     final customerCar = CustomersCarsModel(
  //       id: -1,
  //       customerId: customerId,
  //       carId: car.id,
  //     );
  //     customerCars.add(customerCar);
  //   }
  //   return customerCars;
  // }
}
