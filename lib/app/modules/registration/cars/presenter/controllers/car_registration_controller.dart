import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/services/get/i_car_get_service.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/services/remove/i_car_remove_service.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/services/save/i_car_save_service.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/services/update/i_car_update_service.dart';

class CarRegistrationController extends BaseController {
  CarRegistrationController({
    required ICarSaveService saveService,
    required ICarGetService getService,
    required ICarRemoveService removeService,
    required ICarUpdateService updateService,
  })  : _getService = getService,
        _saveService = saveService,
        _removeService = removeService,
        _updateService = updateService,
        super(InitialState());

  final ICarGetService _getService;
  final ICarSaveService _saveService;
  final ICarRemoveService _removeService;
  final ICarUpdateService _updateService;

  final List<CarModel> _cars = [];
  final List<CarModel> _filteredCars = [];

  Future<void> getCars() async {
    update(LoadingState());
    try {
      _clearAll();
      
      final cars = await _getService.call();

      _cars.addAll(cars);
      _filteredCars.addAll(cars);

      update(SuccessState(data: _filteredCars));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  Future<void> removeCar(CarModel car) async {
    update(LoadingState());
    try {
      await _removeService.call(car.id);
      _cars.remove(car);
      _filteredCars.remove(car);
      update(SuccessState(data: _filteredCars));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  Future<void> saveCar(String model, String brand, int year) async {
    update(LoadingState());
    try {
      await _saveService.call(model, brand, year);
      await getCars();

      update(SuccessState(data: _filteredCars));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

    Future<void> updateCar(String model, String brand, String year, int id) async {
    update(LoadingState());
    try {
      final updatedCar = CarModel(id: id, model: model, brand: brand, year: int.parse(year));
      await _updateService.call(updatedCar);
      await getCars();

      update(SuccessState(data: _filteredCars));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }

  void filterCar(String filterValue) {
    _filteredCars.clear();
    if (filterValue.isEmpty) {
      _filteredCars.addAll(_cars);
    } else {
      _filteredCars.addAll(_cars.where((item) {
        final filterLower = filterValue.toLowerCase();
        final modelMatches = item.model.toLowerCase().contains(filterLower);
        final brandMatches = item.brand.toLowerCase().contains(filterLower);
        final yearMatches = item.year.toString().contains(filterLower);

        return modelMatches || brandMatches || yearMatches;
      }).toList());
    }
    update(SuccessState(data: _filteredCars));
  }

  void _clearAll() {
    _cars.clear();
    _filteredCars.clear();
  }
}
