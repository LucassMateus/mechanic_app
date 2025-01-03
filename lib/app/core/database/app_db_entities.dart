import 'package:mechanic_app/app/core/models/customers_cars.dart';
import 'package:mechanic_app/app/core/models/document_service.dart';
import 'package:mechanic_app/app/core/models/service_cars_model.dart';
import 'package:mechanic_app/app/core/models/service_items_model.dart';
import 'package:mechanic_app/app/core/modules/user/domain/models/user_model.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/models/customer_model.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/models/service_model.dart';
import 'package:sqflite_entity_mapper_orm/sqflite_entity_mapper_orm.dart';

class AppDbEntities extends DbEntityRegisterProvider {
  @override
  List<DbEntityRegister> get entities => [
        DbEntityRegister<UserModel>(
          DbEntity<UserModel>(
            name: 'Users',
            mapToEntity: UserModel.fromDbMap,
            toUpdateOrInsert: (e) => e.upSave(),
            primaryKey: (e) => {'id': e.id},
            columns: [
              IntColumn(
                name: 'id',
                isPrimaryKey: true,
                isAutoIncrement: true,
                isNullable: false,
              ),
              TextColumn(name: 'name', isNullable: false),
              TextColumn(name: 'email', isNullable: false),
              TextColumn(name: 'user', isNullable: false),
              TextColumn(name: 'password', isNullable: false),
              BoolColumn(name: 'admin', isNullable: false),
            ],
          ),
        ),
        DbEntityRegister<CarModel>(
          DbEntity(
            name: 'Cars',
            mapToEntity: CarModel.fromMap,
            toUpdateOrInsert: (e) => e.upSave(),
            primaryKey: (e) => {'id': e.id},
            columns: [
              IntColumn(
                  name: 'id',
                  isPrimaryKey: true,
                  isAutoIncrement: true,
                  isNullable: false),
              TextColumn(name: 'model', isNullable: false),
              TextColumn(name: 'brand', isNullable: false),
              IntColumn(name: 'year', isNullable: false),
            ],
          ),
        ),
        DbEntityRegister<CustomerModel>(
          DbEntity(
            name: 'Customers',
            mapToEntity: CustomerModel.fromMap,
            toUpdateOrInsert: (e) => e.upSave(),
            primaryKey: (e) => {'id': e.id},
            columns: [
              IntColumn(
                  name: 'id',
                  isPrimaryKey: true,
                  isAutoIncrement: true,
                  isNullable: false),
              TextColumn(name: 'name', isNullable: false),
              TextColumn(name: 'phone', isNullable: false),
              TextColumn(name: 'email', isNullable: false),
            ],
          ),
        ),
        DbEntityRegister<ItemModel>(
          DbEntity(
            name: 'Items',
            mapToEntity: ItemModel.fromMap,
            toUpdateOrInsert: (e) => e.upSave(),
            primaryKey: (e) => {'id': e.id},
            columns: [
              IntColumn(
                name: 'id',
                isPrimaryKey: true,
                isAutoIncrement: true,
                isNullable: false,
              ),
              IntColumn(name: 'code', isNullable: false),
              TextColumn(name: 'description', isNullable: false),
              RealColumn(name: 'cost', isNullable: false),
            ],
          ),
        ),
        DbEntityRegister<CustomersCarsModel>(
          DbEntity(
            name: 'CustomersCars',
            mapToEntity: CustomersCarsModel.fromMap,
            toUpdateOrInsert: (e) => e.upSave(),
            primaryKey: (e) => {'id': e.id},
            uniqueKeys: (e) => [
              {'customerId': e.customerId, 'carId': e.carId}
            ],
            columns: [
              IntColumn(
                name: 'id',
                isPrimaryKey: true,
                isAutoIncrement: true,
                isNullable: false,
              ),
              IntColumn(
                name: 'customerId',
                isNullable: false,
                foreignKeys: [
                  ForeignKey(
                    referencedEntity: 'Customers',
                    referencedColumn: 'id',
                  )
                ],
              ),
              IntColumn(
                name: 'carId',
                isNullable: false,
                foreignKeys: [
                  ForeignKey(referencedEntity: 'Cars', referencedColumn: 'id')
                ],
              ),
            ],
          ),
        ),
        DbEntityRegister<ServiceModel>(
          DbEntity(
            name: 'Services',
            mapToEntity: ServiceModel.fromMap,
            toUpdateOrInsert: (e) => e.upSave(),
            primaryKey: (e) => {'id': e.id},
            columns: [
              IntColumn(
                name: 'id',
                isPrimaryKey: true,
                isAutoIncrement: true,
                isNullable: false,
              ),
              TextColumn(name: 'name', isNullable: false),
              TextColumn(name: 'description', isNullable: false),
            ],
          ),
        ),
        DbEntityRegister<ServiceItemsModel>(
          DbEntity(
            name: 'ServicesItems',
            mapToEntity: ServiceItemsModel.fromMap,
            toUpdateOrInsert: (e) => e.upSave(),
            primaryKey: (e) => {'id': e.id},
            uniqueKeys: (e) => [
              {'serviceId': e.serviceId, 'itemId': e.itemId}
            ],
            columns: [
              IntColumn(
                name: 'id',
                isPrimaryKey: true,
                isAutoIncrement: true,
                isNullable: false,
              ),
              IntColumn(
                name: 'serviceId',
                isNullable: false,
                foreignKeys: [
                  ForeignKey(
                    referencedEntity: 'Services',
                    referencedColumn: 'id',
                  )
                ],
              ),
              IntColumn(
                name: 'itemId',
                isNullable: false,
                foreignKeys: [
                  ForeignKey(referencedEntity: 'Items', referencedColumn: 'id')
                ],
              ),
            ],
          ),
        ),
        DbEntityRegister<ServiceCarsModel>(
          DbEntity(
            name: 'ServicesCars',
            mapToEntity: ServiceCarsModel.fromMap,
            toUpdateOrInsert: (e) => e.upSave(),
            // primaryKey: (e) => {'id': e.id},
            primaryKey: (e) => {'serviceId': e.serviceId, 'carId': e.carId},
            uniqueKeys: (e) => [
              {'serviceId': e.serviceId, 'carId': e.carId}
            ],
            columns: [
              IntColumn(
                name: 'id',
                isPrimaryKey: true,
                isAutoIncrement: true,
                isNullable: false,
              ),
              IntColumn(
                name: 'serviceId',
                isNullable: false,
                foreignKeys: [
                  ForeignKey(
                    referencedEntity: 'Services',
                    referencedColumn: 'id',
                    onDeleteAction: OnDeleteAction.cascade,
                  )
                ],
              ),
              IntColumn(
                name: 'carId',
                isNullable: false,
                foreignKeys: [
                  ForeignKey(referencedEntity: 'Cars', referencedColumn: 'id'),
                ],
              ),
              RealColumn(name: 'price', isNullable: false, defaultValue: 0),
              RealColumn(name: 'hours', isNullable: false, defaultValue: 0),
            ],
          ),
        ),
        DbEntityRegister<DocumentService>(
          DbEntity(
            name: 'DocumentService',
            mapToEntity: (p0) {
              throw UnimplementedError();
            },
            toUpdateOrInsert: (p0) {
              throw UnimplementedError();
            },
            primaryKey: (e) {
              throw UnimplementedError();
            },
            columns: [
              IntColumn(
                name: 'id',
                isPrimaryKey: true,
                isAutoIncrement: true,
                isNullable: false,
              ),
              TextColumn(name: 'description', isNullable: false),
              // TextColumn(name: 'obs'),
              TextColumn(name: 'obs', isNullable: false, defaultValue: ''),
            ],
          ),
        ),
      ];
}
