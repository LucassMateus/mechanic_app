import '../../models/customer_model.dart';

abstract interface class ICustomerSaveService {
  Future<CustomerModel> call(CustomerModel dto);
}
