abstract interface class IUserRegisterService {
  Future<void> call(String name, String email, String user, String password);
}