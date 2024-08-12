import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/helpers/functions.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/services/get_all/i_services_get_all_service.dart';

import '../../../cars/domain/models/car_model.dart';
import '../../../items/domain/models/item_model.dart';
import '../../domain/models/service_model.dart';
import '../../domain/services/delete/i_services_delete_service.dart';
import '../../domain/services/save/i_services_save_service.dart';
import '../../domain/services/update/i_services_update_service.dart';

class ServicesRegistrationController extends BaseController {
  ServicesRegistrationController({
    required IServicesGetallService getAllService,
    required IServicesSaveService saveService,
    required IServicesUpdateService updateService,
    required IServicesDeleteService deleteService,
  })  : _getAllService = getAllService,
        _saveService = saveService,
        _updateService = updateService,
        _deleteService = deleteService,
        super(InitialState());

  final IServicesGetallService _getAllService;
  final IServicesSaveService _saveService;
  final IServicesUpdateService _updateService;
  final IServicesDeleteService _deleteService;

  final List<ServiceModel> _services = [];
  // final List<ServiceModel> _filteredServices = [];

  Future<void> getAllServices() async {
    try {
      update(LoadingState());

      final services = await _getAllService.call();
      _services.clear();
      _services.addAll(services);

      update(SuccessState(data: services));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  Future<void> saveService(String name, String description, int hoursAmount,
      List<ItemModel> items, Map<CarModel, double> pricePerCar) async {
    try {
      update(LoadingState());

      await _saveService.call(
        name,
        description,
        hoursAmount,
        items,
        pricePerCar,
      );

      final services = await _getAllService.call();
      _services.clear();
      _services.addAll(services);

      update(SuccessState(data: _services));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  Future<void> updateService(ServiceModel service) async {
    try {
      update(LoadingState());
      await _updateService.call(service);

      final services = await _getAllService.call();
      _services.clear();
      _services.addAll(services);

      update(SuccessState(data: _services));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  Future<void> deleteService(int id) async {
    try {
      update(LoadingState());
      await _deleteService.call(id);

      final services = await _getAllService.call();
      _services.clear();
      _services.addAll(services);
      
      update(SuccessState(data: _services));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  void generateServices() {
    final services = createServiceModels(count: 10);

    update(SuccessState(data: services));
  }
}
