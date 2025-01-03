import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';

abstract interface class ICarRepository {
  Future<List<CarModel>> getAll();
  Future<List<CarModel>> getByCustomer(int id);
  Future<void> save(CarModel car);
  Future<void> remove(CarModel car);
  Future<void> update(CarModel car);
}
