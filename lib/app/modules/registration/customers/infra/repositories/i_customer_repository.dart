import 'package:mechanic_app/app/modules/registration/customers/domain/models/customer_model.dart';

abstract interface class ICostumerRepository {
  Future<List<CustomerModel>> getAll();
  Future<void> save(String name, String emailAddress, String phone);
  Future<void> update(CustomerModel customer);
  Future<void> remove(int id);
}
