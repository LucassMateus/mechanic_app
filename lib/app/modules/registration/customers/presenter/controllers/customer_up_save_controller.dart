import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/dtos/customer_save_dto.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/models/customer_model.dart';
import 'package:sqflite_entity_mapper_orm/sqflite_entity_mapper_orm.dart';

import '../../../../../core/state/base_state.dart';
import '../../../cars/domain/services/get/i_car_get_service.dart';
import '../../domain/services/save/i_customer_save_service.dart';
import '../../domain/services/update/i_customer_update_service.dart';

class CustomerUpSaveController extends BaseController {
  CustomerUpSaveController(
    this.carGetService,
    this.saveService,
    this.updateService,
  ) : super(InitialState());

  @protected
  final ICarGetService carGetService;
  @protected
  final ICustomerSaveService saveService;
  @protected
  final ICustomerUpdateService updateService;

  final List<CarModel> _cars = [];

  List<CarModel> get cars => _cars;

  List<CarModel> selectedCars = [];

  Future<void> init(List<CarModel> customerCars) async {
    try {
      update(LoadingState());
      await Future.delayed(const Duration(seconds: 1));

      selectedCars = customerCars;

      final result = await carGetService();
      _cars.addAll(result);

      update(const SuccessState(data: null));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  void setSelectedCars(List<CarModel> cars) {
    update(LoadingState());
    selectedCars = cars;
    update(const SuccessState(data: null));
  }

  void removeSelectedCar(CarModel car) {
    selectedCars.remove(car);
    update(const SuccessState(data: null));
  }

  Future<void> updateCustomer(CustomerModel customer) async {
    try {
      update(LoadingState());
      await updateService(customer);
      update(const SuccessState(
          data: null, message: 'Cliente atualizado com sucesso'));
    } on Exception catch (e) {
      update(ErrorState(exception: e, message: 'Erro ao atualizar cliente'));
    }
  }

  Future<CustomerModel?> saveCustomer(CustomerSaveDto dto) async {
    try {
      update(LoadingState());
      final customer =
          MapperService().toEntity<CustomerModel, CustomerSaveDto>(dto);

      final savedCustomer = await saveService(customer);

      update(
          const SuccessState(data: null, message: 'Cliente salvo com sucesso'));

      return savedCustomer;
    } on Exception catch (e) {
      update(ErrorState(exception: e, message: 'Erro ao salvar cliente'));
    }
    return null;
  }

  List<CarModel> filterCars(String searchTerm) {
    return _cars
        .where((e) => e.model.toLowerCase().contains(searchTerm))
        .toList();
  }
}
