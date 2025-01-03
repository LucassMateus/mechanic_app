import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/modules/auth/presenter/pages/auth_page.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/core/modules/auth/presenter/controllers/auth_controller.dart';
import 'package:mechanic_app/app/core/modules/user/domain/service/register/i_user_register_service.dart';
import 'package:mechanic_app/app/core/modules/user/domain/service/register/user_register_data_base_service_impl.dart';
import 'package:mechanic_app/app/core/modules/user/infra/repository/user_repository_impl.dart';

import '../user/domain/repositories/i_user_repository.dart';
import '../user/domain/service/login/i_user_login_service.dart';
import '../user/domain/service/login/user_login_service_impl.dart';
import '../user/infra/data_source/user_data_base_dao.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.add<UserDataBaseDao>(UserDataBaseDao.new);
    i.add<IUserRepository>(UserRepositoryImpl.new);
    i.add<IUserLoginService>(UserLoginServiceImpl.new);
    i.add<IUserRegisterService>(UserRegisterDataBaseServiceImpl.new);
    i.addSingleton(AuthController.new);
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
