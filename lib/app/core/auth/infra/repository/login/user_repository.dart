abstract interface class IUserLoginRepository {
  Future<String?> login(String email, String password);
}
