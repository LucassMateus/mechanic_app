import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/core_module.dart';
import 'package:mechanic_app/app/core/modules/register/presenter/controllers/register_controller.dart';
import 'package:mechanic_app/app/core/modules/register/presenter/pages/register_page.dart';
import 'package:mechanic_app/app/core/modules/user/domain/service/register/i_user_register_service.dart';
import 'package:mechanic_app/app/core/modules/user/domain/service/register/user_register_data_base_service_impl.dart';
import 'package:mechanic_app/app/core/modules/user/infra/repository/i_user_repository.dart';
import 'package:mechanic_app/app/core/modules/user/infra/repository/user_data_base_repository_impl.dart';

class RegisterModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.add<IUserRepository>(UserDataBaseRepositoryImpl.new);
    i.add<IUserRegisterService>(UserRegisterDataBaseServiceImpl.new);
    i.addLazySingleton(
      () => RegisterController(registerService: i.get<IUserRegisterService>()),
    );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (_) =>
            RegisterPage(controller: Modular.get<RegisterController>()));
    super.routes(r);
  }
}
