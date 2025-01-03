import 'package:mechanic_app/app/modules/registration/customers/domain/models/customer_model.dart';

import '../../repositories/i_customer_repository.dart';
import 'i_customer_save_service.dart';

class CustomerSaveServiceImpl implements ICustomerSaveService {
  CustomerSaveServiceImpl({required ICostumerRepository repository})
      : _repository = repository;

  final ICostumerRepository _repository;

  @override
  Future<CustomerModel> call(CustomerModel customer) async =>
      _repository.save(customer);
}
