import 'package:mechanic_app/app/core/modules/user/domain/dtos/user_register_dto.dart';
import 'package:mechanic_app/app/core/modules/user/domain/models/user_model.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/dtos/car_save_dto.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/dtos/customer_save_dto.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/models/customer_model.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/dtos/item_save_dto.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/dtos/service_save_dto.dart';
import 'package:sqflite_entity_mapper_orm/sqflite_entity_mapper_orm.dart';

import '../../../modules/registration/services/domain/models/service_model.dart';

class DtoToEntityMapping extends DbCreateMapperProvider {
  @override
  List<CreateMap> get mappings => [
        CreateMap<UserModel, UserRegisterDto>.dtoToEntity((dto) {
          return UserModel(
            id: -1,
            name: dto.name,
            email: dto.email,
            user: dto.user,
            password: dto.password,
            admin: dto.admin,
          );
        }),
        CreateMap<CarModel, CarSaveDto>.dtoToEntity((dto) {
          return CarModel(
            id: -1,
            model: dto.model ?? '',
            brand: dto.brand ?? '',
            year: dto.year ?? -1,
          );
        }),
        CreateMap<CustomerModel, CustomerSaveDto>.dtoToEntity((dto) {
          return CustomerModel(
            id: -1,
            name: dto.name ?? '',
            phoneNumber: dto.phoneNumber ?? '',
            email: dto.email,
            cars: dto.cars,
          );
        }),
        CreateMap<ItemModel, ItemSaveDto>.dtoToEntity((dto) {
          return ItemModel(
            id: -1,
            code: dto.code ?? -1,
            description: dto.description ?? '',
            cost: dto.cost ?? 0.0,
          );
        }),
        CreateMap<ServiceModel, ServiceSaveDto>.dtoToEntity((dto) {
          return ServiceModel(
            id: -1,
            name: dto.name,
            description: dto.description,
            items: dto.items,
            carsDetails: dto.carsDetails,
          );
        }),
      ];
}
