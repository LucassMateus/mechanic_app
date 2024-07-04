import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/helpers/functions.dart';

class ServicesRegistrationController extends BaseController {
  ServicesRegistrationController() : super(InitialState());

   void generateServices() {
    final services = createServiceModels(count: 10);

    update(SuccessState(data: services));
  }
}