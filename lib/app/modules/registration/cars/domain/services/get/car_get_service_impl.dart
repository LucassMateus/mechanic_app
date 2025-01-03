import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';

import '../../repositories/i_car_repository.dart';
import 'i_car_get_service.dart';

class CarGetServiceImpl implements ICarGetService {
  CarGetServiceImpl({required ICarRepository repository}) : _repository = repository;

  final ICarRepository _repository;
  @override
  Future<List<CarModel>> call() async => _repository.getAll();
}
