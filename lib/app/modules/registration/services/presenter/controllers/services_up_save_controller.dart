import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/services/get/i_car_get_service.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/services/get/i_items_get_service.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/dtos/service_car_details_dto.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/save/i_services_save_service.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/update/i_services_update_service.dart';
import 'package:sqflite_entity_mapper_orm/sqflite_entity_mapper_orm.dart';

import '../../../../../core/state/base_state.dart';
import '../../../items/domain/models/item_model.dart';
import '../../domain/dtos/service_save_dto.dart';
import '../../domain/models/service_model.dart';

class ServicesUpSaveController extends BaseController {
  ServicesUpSaveController(
    this.itemsGetUseCase,
    this.carGetUseCase,
    this.saveUseCase,
    this.updateUseCase,
  ) : super(InitialState());

  @protected
  final IItemsGetService itemsGetUseCase;
  @protected
  final ICarGetService carGetUseCase;
  @protected
  final IServicesSaveService saveUseCase;
  @protected
  final IServicesUpdateService updateUseCase;

  final List<ItemModel> _items = [];
  List<ItemModel> get items => _items;

  final List<CarModel> _cars = [];
  List<CarModel> get cars => _cars;

  ServiceModel? _service;
  ServiceModel? get service => _service;

  final serviceSaveDto = ServiceSaveDto();

  Set<ServiceCarDetailsDto> get carsDetailsFromService =>
      serviceSaveDto.carsDetails;

  Set<ItemModel> get itemsFromService => serviceSaveDto.items;

  Future<void> init(ServiceModel? service) async {
    try {
      update(LoadingState());

      _service = service;

      if (service != null) {
        serviceSaveDto.name = service.name;
        serviceSaveDto.description = service.description;
        serviceSaveDto.items.addAll(service.items);
        serviceSaveDto.carsDetails.addAll(service.carsDetails);
      }

      final items = await itemsGetUseCase();
      _items.clear();
      _items.addAll(items);

      final cars = await carGetUseCase();
      _cars.clear();
      _cars.addAll(cars);

      update(const SuccessState(data: null));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  Future<ServiceModel?> saveService() async {
    try {
      update(LoadingState());

      final service = MapperService()
          .toEntity<ServiceModel, ServiceSaveDto>(serviceSaveDto);

      final result = await saveUseCase(service);

      update(const SuccessState(data: null));

      return result;
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
    return null;
  }

  Future<void> updateService() async {
    if (service == null) {
      return;
    }

    final updatedService = service!.copyWith(
      name: serviceSaveDto.name,
      description: serviceSaveDto.description,
      carsDetails: serviceSaveDto.carsDetails,
      items: serviceSaveDto.items,
    );

    if (updatedService == service) {
      return;
    }

    try {
      update(LoadingState());

      await updateUseCase(updatedService);
      _service = updatedService;

      update(const SuccessState(data: null));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }
}
