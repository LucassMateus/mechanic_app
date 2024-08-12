
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';

abstract interface class ICarRepository {
  Future<List<CarModel>> getAll();
  Future<void> save(String model, String brand, int year);
  Future<void> remove(int id);
  Future<void> update(CarModel car);
}