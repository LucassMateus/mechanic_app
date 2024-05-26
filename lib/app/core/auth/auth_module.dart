import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/auth/presenter/pages/auth_page.dart';
import 'package:mechanic_app/app/core/auth/infra/repository/credential/i_user_credential_repository.dart';
import 'package:mechanic_app/app/core/auth/infra/repository/credential/user_credential_repository_impl.dart';
import 'package:mechanic_app/app/core/auth/infra/repository/login/user_repository.dart';
import 'package:mechanic_app/app/core/auth/infra/repository/login/user_repository_impl.dart';
import 'package:mechanic_app/app/core/auth/domain/service/credential/i_user_fetch_saved_credential_service.dart';
import 'package:mechanic_app/app/core/auth/domain/service/credential/i_user_save_credential_service.dart';
import 'package:mechanic_app/app/core/auth/domain/service/credential/user_fetch_saved_credential_service_impl.dart';
import 'package:mechanic_app/app/core/auth/domain/service/credential/user_save_credential_service_impl.dart';
import 'package:mechanic_app/app/core/auth/domain/service/login/i_user_login_service.dart';
import 'package:mechanic_app/app/core/auth/domain/service/login/user_login_service_impl.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/core/auth/presenter/controllers/auth_controller.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.add<IUserLoginRepository>(UserLoginRepositoryImpl.new);
    i.add<IUserCredentialRepository>(UserCredentialRepositoryImpl.new);
    i.add<IUserLoginService>(UserLoginServiceImpl.new);
    i.add<IUserFetchSavedCredentialService>(
        UserFetchSavedCredentialServiceImpl.new);
    i.add<IUserSaveCredentialService>(UserSaveCredentialServiceImpl.new);
    i.addSingleton(
      () => AuthController(
          loginService: i.get<IUserLoginService>(),
          credentialService: i.get<IUserFetchSavedCredentialService>(),
          credentialSaveService: i.get<IUserSaveCredentialService>()),
    );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => AuthPage(controller: Modular.get<AuthController>()),
    );
    super.routes(r);
  }
}
