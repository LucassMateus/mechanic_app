import 'package:flutter/material.dart';

import 'package:mechanic_app/app/modules/registration/services/domain/models/service_model.dart';
import 'package:mechanic_app/app/modules/registration/services/external/data_sources/services_local_dao.dart';

import '../../domain/repositories/i_services_repository.dart';

class ServicesDataBaseRepositoryImpl implements IServicesRepository {
  ServicesDataBaseRepositoryImpl({required this.servicesLocalDao});

  @protected
  final ServicesLocalDao servicesLocalDao;

  @override
  Future<void> delete(ServiceModel service) async =>
      servicesLocalDao.remove(service);

  @override
  Future<List<ServiceModel>> getAll() async => servicesLocalDao.getAll();

  @override
  Future<ServiceModel> save(ServiceModel service) async =>
      servicesLocalDao.saveService(service);

  @override
  Future<void> update(ServiceModel service) async =>
      servicesLocalDao.updateService(service);

  @override
  Future<List<ServiceModel>> getWithFilter(String searchTerm) =>
      servicesLocalDao.getWithFilter(searchTerm);
}
