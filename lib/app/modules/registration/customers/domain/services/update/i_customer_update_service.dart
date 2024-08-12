import '../../models/customer_model.dart';

abstract interface class ICustomerUpdateService {
  Future<void> call(CustomerModel customer);
}
