import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import '../../repositories/i_car_repository.dart';
import 'i_car_save_service.dart';

class CarSaveServiceImpl implements ICarSaveService {
  CarSaveServiceImpl({required ICarRepository repository})
      : _repository = repository;

  final ICarRepository _repository;

  @override
  Future<void> call(CarModel car) async {
    await _repository.save(car);
  }
}
