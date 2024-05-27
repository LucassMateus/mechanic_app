import 'dart:developer';

import 'package:mechanic_app/app/core/exceptions/repository_exception.dart';
import 'package:mechanic_app/app/core/restClient/shared/rest_client.dart';
import 'package:mechanic_app/app/helpers/functions.dart';
import 'package:mechanic_app/app/modules/service_order/domain/models/service_order.dart';

import 'i_service_order_repository.dart';

class ServiceOrderRepositoryImpl implements IServiceOrderRepository {
  ServiceOrderRepositoryImpl({
    required RestClient restClient,
  }) : _restClient = restClient;

  final RestClient _restClient;

  @override
  Future<List<ServiceOrderModel>> getAll() async {
    try {
      final List<ServiceOrderModel> serviceOrders = generateServiceOrders(10);

      return serviceOrders;
    } catch (e, s) {
      log('Erro ao buscar as ordens de serviço', error: e, stackTrace: s);
      throw RepositoryException(message: e.toString());
    }
  }
}
