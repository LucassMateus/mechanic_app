import 'package:mechanic_app/app/core/controller/base_controller.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/modules/home/domain/services/i_home_get_cars_service.dart';
import 'package:mechanic_app/app/modules/service_order/home/domain/models/service_order.dart';

class HomeController extends BaseController {
  HomeController({
    required IHomeGetCarsService service,
  })  : _service = service,
        super(InitialState());

  final IHomeGetCarsService _service;

  Future<void> getServiceOrders() async {
    try {
      update(LoadingState());

      final result = await _service.call();

      update(SuccessState<List<ServiceOrderModel>>(data: result));
    } on Exception catch (e) {
      update(ErrorState(exception: Exception(e)));
    }
  }
}
