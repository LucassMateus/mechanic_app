import 'package:mechanic_app/app/core/auth/domain/models/user_model.dart';
import 'package:mechanic_app/app/core/auth/infra/repository/credential/i_user_credential_repository.dart';
import 'package:mechanic_app/app/core/local_storage/i_local_storage.dart';

class UserCredentialRepositoryImpl implements IUserCredentialRepository {
  UserCredentialRepositoryImpl({required ILocalStorage localStorage})
      : _localStorage = localStorage;

  final ILocalStorage _localStorage;

  @override
  Future<UserModel?> get(String key) async {
    UserModel? savedCredentials;
    final response = await _localStorage.get(key);

    if (response != null) {
      savedCredentials = UserModel.fromJson(response);
    }

    return savedCredentials;
  }

  @override
  Future<void> save(String key, value) async =>
      await _localStorage.save(key, value);
}
