import 'package:lucid_validation/lucid_validation.dart';
import 'package:mechanic_app/app/core/modules/user/domain/dtos/user_login_dto.dart';

class UserLoginValidator extends LucidValidator<UserLoginDto> {
  UserLoginValidator() {
    ruleFor((dto) => dto.userName, key: 'userName') //
        .isNotNull();

    ruleFor((dto) => dto.password, key: 'password') //
        .isNotNull();
    // .notEmpty()
    // .minLength(8, message: 'Must be at least 8 characters long')
    // .mustHaveLowercase()
    // .mustHaveUppercase()
    // .mustHaveNumbers()
    // .mustHaveSpecialCharacter();
  }
}
