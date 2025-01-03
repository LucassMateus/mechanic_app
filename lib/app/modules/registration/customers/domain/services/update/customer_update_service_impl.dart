import 'package:mechanic_app/app/modules/registration/customers/domain/models/customer_model.dart';
import '../../repositories/i_customer_repository.dart';
import 'i_customer_update_service.dart';

class CustomerUpdateServiceImpl implements ICustomerUpdateService {
  CustomerUpdateServiceImpl({required ICostumerRepository repository})
      : _repository = repository;

  final ICostumerRepository _repository;
  @override
  Future<void> call(CustomerModel customer) async =>
      _repository.update(customer);
}
