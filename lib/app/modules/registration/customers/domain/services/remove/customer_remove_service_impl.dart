import 'package:mechanic_app/app/modules/registration/customers/domain/services/remove/i_customer_remove_service.dart';

import '../../models/customer_model.dart';
import '../../repositories/i_customer_repository.dart';

class CustomerRemoveServiceImpl implements ICustomerRemoveService {
  CustomerRemoveServiceImpl({required ICostumerRepository repository})
      : _repository = repository;

  final ICostumerRepository _repository;
  @override
  Future<void> call(CustomerModel customer) async =>
      _repository.remove(customer);
}
