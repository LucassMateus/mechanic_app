import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';

import '../../domain/models/service_model.dart';
import '../../domain/services/delete/i_services_delete_service.dart';
import '../../domain/services/filter/i_services_filter_service.dart';
import '../../domain/services/get_all/i_services_get_all_service.dart';
import '../../domain/services/save/i_services_save_service.dart';
import '../../domain/services/update/i_services_update_service.dart';

class ServicesListController extends BaseController {
  ServicesListController(
    this.getAllUseCase,
    this.saveUseCase,
    this.updateUseCase,
    this.deleteUseCase,
    this.filterUseCase,
  ) : super(InitialState());

  @protected
  final IServicesGetallService getAllUseCase;
  @protected
  final IServicesSaveService saveUseCase;
  @protected
  final IServicesUpdateService updateUseCase;
  @protected
  final IServicesDeleteService deleteUseCase;
  @protected
  final IServicesFilterService filterUseCase;

  final List<ServiceModel> services = [];

  Future<void> init() async {
    try {
      update(LoadingState());

      final services = await getAllUseCase();
      this.services.clear();
      this.services.addAll(services);

      update(SuccessState(
        data: services,
        message: 'Serviços carregados com sucesso.',
      ));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  Future<void> getAllServices() async {
    try {
      update(LoadingState());

      final services = await getAllUseCase();
      this.services.clear();
      this.services.addAll(services);

      update(SuccessState(data: services));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  Future<void> deleteService(ServiceModel service) async {
    try {
      update(LoadingState());
      await deleteUseCase(service);

      final services = await getAllUseCase();
      this.services.clear();
      this.services.addAll(services);

      update(SuccessState(data: services));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  void updateService(ServiceModel result) {
    final index = services.indexWhere((element) => element.id == result.id);
    services[index] = result;
    update(SuccessState(data: services));
  }

  void addService(ServiceModel result) {
    services.add(result);

    update(SuccessState(data: services));
  }

  Future<void> filterServices(String searchTerm) async {
    try {
      update(LoadingState());
      debugPrint('Filtering services...');
      Future.delayed(const Duration(milliseconds: 500));
      final filteredServices = await filterUseCase(searchTerm);
      services.clear();
      services.addAll(filteredServices);

      update(SuccessState(data: filteredServices));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }
}
