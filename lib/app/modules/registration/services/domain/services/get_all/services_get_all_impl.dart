import 'package:mechanic_app/app/modules/registration/services/domain/models/service_model.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/get_all/i_services_get_all_service.dart';
import 'package:mechanic_app/app/modules/registration/services/infra/repositories/i_services_repository.dart';

class ServicesGetAllImpl implements IServicesGetallService {
  ServicesGetAllImpl({required IServicesRepository repository})
      : _repository = repository;

  final IServicesRepository _repository;

  @override
  Future<List<ServiceModel>> call() async => await _repository.getAll();
}
