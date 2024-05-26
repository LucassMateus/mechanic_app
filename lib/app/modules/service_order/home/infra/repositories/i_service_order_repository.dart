import 'package:mechanic_app/app/modules/service_order/home/domain/models/service_order.dart';

abstract interface class IServiceOrderRepository {
  Future<List<ServiceOrderModel>> getAll();
}
