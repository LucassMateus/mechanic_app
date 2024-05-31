import 'package:mechanic_app/app/core/exceptions/repository_exception.dart';

import '../../../infra/repository/credential/i_user_credential_repository.dart';
import 'i_user_save_credential_service.dart';

class UserSaveCredentialServiceImpl implements IUserSaveCredentialService {
  UserSaveCredentialServiceImpl({required IUserCredentialRepository repository})
      : _repository = repository;

  final IUserCredentialRepository _repository;

  @override
  Future<void> call(String key, dynamic value) async {
    try {
      await _repository.save(key, value);
    } catch (e) {
      throw RepositoryException(message: e.toString());
    }
  }
}
