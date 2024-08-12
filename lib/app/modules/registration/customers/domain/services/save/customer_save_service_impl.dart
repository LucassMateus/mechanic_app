import '../../../infra/repositories/i_customer_repository.dart';
import 'i_customer_save_service.dart';

class CustomerSaveServiceImpl implements ICustomerSaveService {
  CustomerSaveServiceImpl({required ICostumerRepository repository})
      : _repository = repository;

  final ICostumerRepository _repository;

  @override
  Future<void> call(String name, String emailAddress, String phone) async =>
      await _repository.save(name, emailAddress, phone);
}
