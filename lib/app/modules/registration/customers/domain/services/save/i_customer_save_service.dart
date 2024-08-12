abstract interface class ICustomerSaveService {
  Future<void> call(String name, String emailAddress, String phone);
}