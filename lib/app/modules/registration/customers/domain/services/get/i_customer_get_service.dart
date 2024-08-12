import '../../models/customer_model.dart';

abstract interface class ICustomerGetService {
  Future<List<CustomerModel>> call();
}
