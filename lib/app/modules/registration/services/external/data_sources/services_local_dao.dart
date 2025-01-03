import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/database/app_db_context.dart';
import 'package:mechanic_app/app/core/models/service_cars_model.dart';
import 'package:mechanic_app/app/core/models/service_items_model.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/dtos/service_car_details_dto.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/models/service_model.dart';
import 'package:sqflite_entity_mapper_orm/sqflite_entity_mapper_orm.dart';

class ServicesLocalDao extends SqliteGenericRepository<ServiceModel> {
  ServicesLocalDao({required this.dbContext, required this.dbConnection})
      : super(dbSet: dbContext.services);

  @protected
  final AppDbContext dbContext;
  @protected
  final SqliteDbConnection dbConnection;

  Future<List<ServiceModel>> getAll() async {
    final services = await dbContext.services.findAll();

    for (var service in services) {
      final items = dbContext.items;
      final serviceItemsQuery = items.query
          .select()
          .join('ServicesItems i', onClause: 'i.itemId = x.id')
          .where('i.serviceId = ${service.id}');

      final serviceItemsResults = await serviceItemsQuery.execute();
      final serviceItems = serviceItemsResults.entities;

      service.items.addAll(serviceItems);

      final serviceCarsQuery = dbContext.servicesCars.query
          .select()
          .where('serviceId = ${service.id}');

      final serviceCarsResults = await serviceCarsQuery.execute();
      final serviceCars = serviceCarsResults.entities;

      for (var serviceCar in serviceCars) {
        final car =
            await dbContext.cars.findFirstOrNull('id = ?', [serviceCar.carId]);

        if (car != null) {
          service.carsDetails.add(ServiceCarDetailsDto(
            car,
            pricePerCar: serviceCar.price,
            hoursPerCar: serviceCar.hours,
          ));
        }
      }
    }

    return services;
  }

  Future<ServiceModel> saveService(ServiceModel service) async {
    final transaction = dbConnection.getTransaction;
    try {
      await transaction.open();
      dbContext.services.transaction(transaction).insert(service);

      final nextServiceId = await dbContext.services.getNextInsertRowId();

      for (var item in service.items) {
        final serviceItem = ServiceItemsModel(
          id: -1,
          serviceId: nextServiceId,
          itemId: item.id,
        );
        dbContext.servicesItems.transaction(transaction).insert(serviceItem);
      }

      for (var carDetails in service.carsDetails) {
        final serviceCar = ServiceCarsModel(
          id: -1,
          serviceId: nextServiceId,
          carId: carDetails.car.id,
          price: carDetails.pricePerCar,
          hours: carDetails.hoursPerCar,
        );
        dbContext.servicesCars.transaction(transaction).insert(serviceCar);
      }

      await transaction.commit();
      final insertedService = service.copyWith(id: nextServiceId);

      return insertedService;
    } finally {
      transaction.close();
    }
  }

  Future<void> updateService(ServiceModel service) async {
    final transaction = dbConnection.getTransaction;
    try {
      final List<ServiceItemsModel> serviceItems = [];
      final List<ServiceCarsModel> serviceCars = [];

      await transaction.open();

      dbContext.services.transaction(transaction).update(service);

      final serviceItemToRemoveQuery = await dbContext //
          .servicesItems
          .query
          .select()
          .where('serviceId = ${service.id}')
          .and()
          .where('itemId not in (${service.items.map((x) => x.id).join(',')})')
          .execute();

      final serviceItemsToRemove = serviceItemToRemoveQuery.entities;
      for (var item in serviceItemsToRemove) {
        dbContext.servicesItems.transaction(transaction).delete(item);
      }

      final serviceCarToRemoveQuery = await dbContext //
          .servicesCars
          .query
          .select()
          .where('serviceId = ${service.id}')
          .and()
          .where(
            'carId not in (${service.carsDetails.map((x) => x.car.id).join(',')})',
          )
          .execute();

      final serviceCarsToRemove = serviceCarToRemoveQuery.entities;
      for (var car in serviceCarsToRemove) {
        dbContext.servicesCars.transaction(transaction).delete(car);
      }

      for (var item in service.items) {
        final serviceItem = ServiceItemsModel(
          id: -1,
          serviceId: service.id,
          itemId: item.id,
        );
        serviceItems.add(serviceItem);
      }

      for (var carDetails in service.carsDetails) {
        final serviceCar = ServiceCarsModel(
          id: -1,
          serviceId: service.id,
          carId: carDetails.car.id,
          price: carDetails.pricePerCar,
          hours: carDetails.hoursPerCar,
        );
        serviceCars.add(serviceCar);
      }

      await dbContext.servicesItems
          .transaction(transaction)
          .merge(serviceItems);

      await dbContext.servicesCars //
          .transaction(transaction)
          .merge(serviceCars);

      await transaction.commit();

      // return insertedService;
    } finally {
      transaction.close();
    }
  }

  Future<List<ServiceModel>> getWithFilter(String searchTerm) async {
    final servicesQuery = dbContext //
        .services
        .query
        .select()
        .where('name like \'%$searchTerm%\'')
        .or('description like \'%$searchTerm%\'');

    final servicesResults = await servicesQuery.execute();
    final services = servicesResults.entities;

    for (var service in services) {
      final items = dbContext.items;
      final serviceItemsQuery = items.query
          .select()
          .join('ServicesItems i', onClause: 'i.itemId = x.id')
          .where('i.serviceId = ${service.id}');

      final serviceItemsResults = await serviceItemsQuery.execute();
      final serviceItems = serviceItemsResults.entities;

      service.items.addAll(serviceItems);

      final serviceCarsQuery = dbContext.servicesCars.query
          .select()
          .where('serviceId = ${service.id}');

      final serviceCarsResults = await serviceCarsQuery.execute();
      final serviceCars = serviceCarsResults.entities;

      for (var serviceCar in serviceCars) {
        final car =
            await dbContext.cars.findFirstOrNull('id = ?', [serviceCar.carId]);

        if (car != null) {
          service.carsDetails.add(ServiceCarDetailsDto(
            car,
            pricePerCar: serviceCar.price,
            hoursPerCar: serviceCar.hours,
          ));
        }
      }
    }

    return services;
  }
}
