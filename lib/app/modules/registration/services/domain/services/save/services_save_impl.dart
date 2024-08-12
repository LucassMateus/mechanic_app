import 'package:mechanic_app/app/modules/registration/services/infra/repositories/i_services_repository.dart';

import '../../../../cars/domain/models/car_model.dart';
import '../../../../items/domain/models/item_model.dart';
import 'i_services_save_service.dart';

class ServicesSaveServiceImpl implements IServicesSaveService {
  ServicesSaveServiceImpl({required IServicesRepository repository})
      : _repository = repository;

  final IServicesRepository _repository;

  @override
  Future<void> call(String name, String description, int hoursAmount,
          List<ItemModel> items, Map<CarModel, double> pricePerCar) async =>
      await _repository.save(
          name, description, hoursAmount, items, pricePerCar);
}
