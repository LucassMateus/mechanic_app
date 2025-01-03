import 'package:mechanic_app/app/modules/registration/services/domain/repositories/i_services_repository.dart';

import '../../models/service_model.dart';
import 'i_services_save_service.dart';

class ServicesSaveServiceImpl implements IServicesSaveService {
  ServicesSaveServiceImpl({required IServicesRepository repository})
      : _repository = repository;

  final IServicesRepository _repository;

  @override
  Future<ServiceModel> call(ServiceModel service) async =>
      _repository.save(service);
}
