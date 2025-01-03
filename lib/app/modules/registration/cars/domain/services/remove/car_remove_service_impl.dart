import '../../models/car_model.dart';
import '../../repositories/i_car_repository.dart';
import 'i_car_remove_service.dart';

class CarRemoveServiceImpl implements ICarRemoveService {
  CarRemoveServiceImpl({required ICarRepository repository})
      : _repository = repository;

  final ICarRepository _repository;

  @override
  Future<void> call(CarModel car) async => await _repository.remove(car);
}
