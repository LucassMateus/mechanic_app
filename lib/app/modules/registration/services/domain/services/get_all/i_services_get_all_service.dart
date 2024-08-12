import '../../models/service_model.dart';

abstract interface class IServicesGetallService {
  Future<List<ServiceModel>> call();
}
