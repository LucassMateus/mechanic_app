import 'package:mechanic_app/app/helpers/functions.dart';
import 'package:mechanic_app/app/modules/service_order/domain/models/service_order.dart';

import '../../domain/repositories/i_service_order_repository.dart';

class ServiceOrderRepositoryImpl implements IServiceOrderRepository {
  ServiceOrderRepositoryImpl();

  @override
  Future<List<ServiceOrderModel>> getAll() async {
    final List<ServiceOrderModel> serviceOrders = generateServiceOrders(10);

    return serviceOrders;
  }
}
