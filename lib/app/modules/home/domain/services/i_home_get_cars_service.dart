import 'package:mechanic_app/app/modules/service_order/domain/models/service_order.dart';

abstract interface class IHomeGetCarsService {
  Future<List<ServiceOrderModel>> call();
}
