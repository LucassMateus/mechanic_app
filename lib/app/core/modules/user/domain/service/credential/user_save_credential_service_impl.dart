import '../../repositories/i_user_credential_repository.dart';
import 'i_user_save_credential_service.dart';

class UserSaveCredentialServiceImpl implements IUserSaveCredentialService {
  UserSaveCredentialServiceImpl({required IUserCredentialRepository repository})
      : _repository = repository;

  final IUserCredentialRepository _repository;

  @override
  Future<void> call(String key, dynamic value) async {
    await _repository.save(key, value);
  }
}
