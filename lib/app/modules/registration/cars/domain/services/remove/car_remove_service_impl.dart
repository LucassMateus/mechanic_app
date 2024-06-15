import 'package:mechanic_app/app/modules/registration/cars/infra/repositories/i_car_repository.dart';

import 'i_car_remove_service.dart';

class CarRemoveServiceImpl implements ICarRemoveService {
  CarRemoveServiceImpl({required ICarRepository repository})
      : _repository = repository;

  final ICarRepository _repository;

  @override
  Future<void> call(int id) async => await _repository.remove(id);
}
