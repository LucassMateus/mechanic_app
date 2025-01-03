import 'package:mechanic_app/app/modules/registration/customers/domain/models/customer_model.dart';

abstract interface class ICostumerRepository {
  Future<List<CustomerModel>> getAll();
  Future<CustomerModel> save(CustomerModel customer);
  Future<void> update(CustomerModel customer);
  Future<void> remove(CustomerModel customer);
}
