import 'package:mechanic_app/app/modules/registration/services/domain/models/service_model.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/repositories/i_services_repository.dart';

import 'i_services_delete_service.dart';

class ServicesDeleteServiceImpl implements IServicesDeleteService {
  ServicesDeleteServiceImpl({required IServicesRepository repository})
      : _repository = repository;

  final IServicesRepository _repository;

  @override
  Future<void> call(ServiceModel service) async =>
      await _repository.delete(service);
}
