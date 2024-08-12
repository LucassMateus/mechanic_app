import 'package:mechanic_app/app/modules/registration/customers/domain/models/customer_model.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/services/get/i_customer_get_service.dart';
import 'package:mechanic_app/app/modules/registration/customers/infra/repositories/i_customer_repository.dart';

class CustomerGetServiceImpl implements ICustomerGetService {
  CustomerGetServiceImpl({required ICostumerRepository repository})
      : _repository = repository;

  final ICostumerRepository _repository;

  @override
  Future<List<CustomerModel>> call() async => _repository.getAll();
}
