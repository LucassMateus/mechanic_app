import 'package:flutter/cupertino.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';

import '../../domain/repositories/i_car_repository.dart';
import '../../external/data_sources/car_local_dao.dart';

class CarRepositoryImpl implements ICarRepository {
  CarRepositoryImpl({required this.localDAO});

  @protected
  final CarsLocalDAO localDAO;

  @override
  Future<List<CarModel>> getAll() async => localDAO.getAll();

  @override
  Future<void> save(CarModel car) async => localDAO.save(car);

  @override
  Future<void> remove(CarModel car) async => localDAO.remove(car);

  @override
  Future<void> update(CarModel car) async => localDAO.update(car);

  @override
  Future<List<CarModel>> getByCustomer(int id) async => localDAO.getById(id);
}
