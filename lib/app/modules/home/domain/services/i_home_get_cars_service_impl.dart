import 'dart:developer';

import 'package:mechanic_app/app/core/exceptions/service_exception.dart';
import 'package:mechanic_app/app/modules/service_order/domain/models/service_order.dart';

import '../../../service_order/domain/repositories/i_service_order_repository.dart';
import 'i_home_get_cars_service.dart';

class HomeGetCarsServiceImpl implements IHomeGetCarsService {
  HomeGetCarsServiceImpl({
    required IServiceOrderRepository repository,
  }) : _repository = repository;

  final IServiceOrderRepository _repository;

  @override
  Future<List<ServiceOrderModel>> call() async {
    try {
      final result = await _repository.getAll();

      return result;
    } catch (e, s) {
      log(
        'Erro ao buscar as próximas ordens de serviço',
        error: e,
        stackTrace: s,
      );
      throw ServiceException(message: e.toString());
    }
  }
}
