import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';

abstract interface class ICarRemoveService {
  Future<void> call(CarModel car);
}
