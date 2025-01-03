import 'package:flutter/cupertino.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/repositories/i_car_repository.dart';

import 'i_cars_get_by_customer_service.dart';

class CarsGetByCustomerServiceImpl implements ICarsGetByCustomerService {
  CarsGetByCustomerServiceImpl({required this.repository});

  @protected
  ICarRepository repository;

  @override
  Future<List<CarModel>> call(int id) => repository.getByCustomer(id);
}
