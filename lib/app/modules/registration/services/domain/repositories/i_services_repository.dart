import '../models/service_model.dart';

abstract interface class IServicesRepository {
  Future<List<ServiceModel>> getAll();
  Future<List<ServiceModel>> getWithFilter(String searchTerm);
  Future<ServiceModel> save(ServiceModel service);
  Future<void> update(ServiceModel service);
  Future<void> delete(ServiceModel service);
}
