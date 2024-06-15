import 'package:mechanic_app/app/modules/registration/cars/infra/repositories/i_car_repository.dart';

import 'i_car_save_service.dart';

class CarSaveServiceImpl implements ICarSaveService {
  CarSaveServiceImpl({required ICarRepository repository}) : _repository = repository;

  final ICarRepository _repository;

  @override
  Future<void> call(String model, String brand, int year) async =>
      await _repository.save(model, brand, year);
}
