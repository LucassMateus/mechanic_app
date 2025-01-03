import 'package:mechanic_app/app/modules/registration/services/domain/models/service_model.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/repositories/i_services_repository.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/filter/i_services_filter_service.dart';

class ServicesFilterServiceImpl implements IServicesFilterService {
  ServicesFilterServiceImpl({required IServicesRepository repository})
      : _repository = repository;

  final IServicesRepository _repository;

  @override
  Future<List<ServiceModel>> call(String searchTerm) =>
      _repository.getWithFilter(searchTerm);
}
