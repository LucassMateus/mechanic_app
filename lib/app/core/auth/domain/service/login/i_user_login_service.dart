abstract interface class IUserLoginService {
  Future<String?> call(String user, String password, bool saveLogin);
}
