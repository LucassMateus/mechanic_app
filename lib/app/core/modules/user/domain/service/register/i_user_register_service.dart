import '../../dtos/user_register_dto.dart';

abstract interface class IUserRegisterService {
  Future<void> call(UserRegisterDto dto);
}
