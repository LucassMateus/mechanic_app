import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/local_storage/i_local_storage.dart';
import 'package:mechanic_app/app/core/local_storage/shared_preferences_impl.dart';
import 'package:mechanic_app/app/core/restClient/shared/rest_client.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.add<RestClient>(RestClient.new);
    i.addSingleton<ILocalStorage>(SharedPreferencesImpl.new);
    super.exportedBinds(i);
  }
}
