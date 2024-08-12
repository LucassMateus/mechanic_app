import '../../../cars/domain/models/car_model.dart';
import '../../../items/domain/models/item_model.dart';
import '../../domain/models/service_model.dart';

abstract interface class IServicesRepository {
  Future<List<ServiceModel>> getAll();
  Future<void> save(String name, String description, int hoursAmount,
      List<ItemModel> items, Map<CarModel, double> pricePerCar);
  Future<void> update(ServiceModel service);
  Future<void> delete(int id);
}

