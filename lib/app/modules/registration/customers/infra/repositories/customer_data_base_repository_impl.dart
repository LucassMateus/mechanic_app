import 'package:mechanic_app/app/modules/registration/customers/domain/models/customer_model.dart';

import '../../domain/repositories/i_customer_repository.dart';
import '../../external/data_sources/customers_local_dao.dart';

class CostumerDataBaseRepositoryImpl implements ICostumerRepository {
  CostumerDataBaseRepositoryImpl({required CustomersLocalDao localDao})
      : _localDao = localDao;

  final CustomersLocalDao _localDao;

  @override
  Future<List<CustomerModel>> getAll() async => _localDao.getAll();

  @override
  Future<CustomerModel> save(CustomerModel customer) async =>
      _localDao.saveCustomer(customer);

  @override
  Future<void> remove(CustomerModel customer) async =>
      _localDao.remove(customer);

  @override
  Future<void> update(CustomerModel customer) async =>
      _localDao.update(customer);
}
