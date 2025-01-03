import 'package:mechanic_app/app/modules/registration/customers/domain/models/customer_model.dart';

abstract interface class ICustomerRemoveService {
  Future<void> call(CustomerModel customer);
}
