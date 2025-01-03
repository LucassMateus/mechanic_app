import 'package:mechanic_app/app/core/database/mappings/dto_to_entity_mapping.dart';
import 'package:mechanic_app/app/core/database/mappings/entity_to_dto_mapping.dart';
import 'package:mechanic_app/app/core/models/customers_cars.dart';
import 'package:mechanic_app/app/core/models/document_service.dart';
import 'package:mechanic_app/app/core/models/service_cars_model.dart';
import 'package:mechanic_app/app/core/models/service_items_model.dart';
import 'package:mechanic_app/app/core/modules/user/domain/models/user_model.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/models/customer_model.dart';
import 'package:sqflite_entity_mapper_orm/sqflite_entity_mapper_orm.dart';

import '../../modules/registration/items/domain/models/item_model.dart';
import '../../modules/registration/services/domain/models/service_model.dart';
import 'app_db_entities.dart';

class AppDbContext extends DbContext with QueryMixin {
  final users = DbSet<UserModel>();
  final cars = DbSet<CarModel>();
  final customers = DbSet<CustomerModel>();
  final items = DbSet<ItemModel>();
  final customersCars = DbSet<CustomersCarsModel>();
  final services = DbSet<ServiceModel>();
  final servicesItems = DbSet<ServiceItemsModel>();
  final servicesCars = DbSet<ServiceCarsModel>();
  final documentService = DbSet<DocumentService>();

  AppDbContext({
    required super.dbEntityService,
    required super.dbConnection,
  });

  @override
  List<DbSet> get dbSets => [
        users,
        cars,
        customers,
        items,
        customersCars,
        services,
        servicesItems,
        servicesCars,
        documentService,
      ];

  @override
  void binds() {
    super.registerAutoEntities(AppDbEntities());

    super.addAutoMappings(DtoToEntityMapping());
    super.addAutoMappings(EntityToDtoMapping());
  }

  @override
  SqliteDbConnection get connection => super.dbConnection;
}
