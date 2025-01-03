import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';

import '../../repositories/i_car_repository.dart';
import 'i_car_update_service.dart';

class CarUpdateServiceImpl implements ICarUpdateService {
  CarUpdateServiceImpl({required ICarRepository repository}) : _repository = repository;

  final ICarRepository _repository;

  @override
  Future<void> call(CarModel car) async =>
      await _repository.update(car);
}
