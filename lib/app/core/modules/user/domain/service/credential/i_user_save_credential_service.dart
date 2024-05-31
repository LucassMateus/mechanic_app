abstract interface class IUserSaveCredentialService {
  Future<void> call(String key, dynamic value);
}
